//
//  MapViewController.swift
//  pokemongo
//
//  Created by Kevin Mudiandambo on 12/14/17.
//  Copyright © 2017 Kevin Mudiandambo. All rights reserved.
//

import UIKit
import MapKit   // necessary for having the MKMapView

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var updateCount = 0
    var manager = CLLocationManager()
    
    var pokemon : [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemon = getAllPokemon()
        
        manager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // realize that the authorization is only in use
            mapView.showsUserLocation = true
            // ask for current location, continually update
            manager.startUpdatingLocation()
            mapView.delegate = self
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if let center = self.manager.location?.coordinate {
                
                var annoCord = center
                
                annoCord.latitude += self.generateRandomCoordinates()
                annoCord.longitude += self.generateRandomCoordinates()
                let randomIndex = arc4random_uniform(UInt32(self.pokemon.count))
                let annotation = PokemonAnnotation(coord: annoCord, pokemon: self.pokemon[Int(randomIndex)])
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let anView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            anView.image = UIImage(named: "player")
            var frame = anView.frame
            frame.size.height = 50
            frame.size.width = 50
            anView.frame = frame
            return anView
        } else {
            
            if let pokeAnnotation = annotation as? PokemonAnnotation {
                if let imageName = pokeAnnotation.pokemon.imageName {
                    anView.image = UIImage(named: imageName)
                    var frame = anView.frame
                    frame.size.height = 50
                    frame.size.width = 50
                    anView.frame = frame
                }

            }
            return anView
        }
    }
    

    /*
     We'll make sure the app starts zoomed in to the current location of the phone
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if updateCount < 3 {
            
            if let coordinate = manager.location?.coordinate {
                let region = MKCoordinateRegionMakeWithDistance(coordinate, 400, 400)
                mapView.setRegion(region, animated: true)
            }
            
            updateCount += 1
        } else {
            // stops updating the location
            // saves a little battery
            manager.stopUpdatingLocation()
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        
            if view.annotation is MKUserLocation {
                // we're selecting the trainer, we don't do anything currently
            } else {
                if let center = manager.location?.coordinate {
                    if let pokemonLocationCenter = view.annotation?.coordinate {
                        let region = MKCoordinateRegionMakeWithDistance(pokemonLocationCenter, 200, 200)
                        mapView.setRegion(region, animated: false)
                        
                        if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(center)) {
                            // user can catch
                            if let pokeAnn = view.annotation as? PokemonAnnotation {
                                pokeAnn.pokemon.isCaught = true
                                if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                                    try? context.save()
                                    if let name = pokeAnn.pokemon.name {
                                        let alertVC = UIAlertController(title: "Congratulations", message: "You caught a \(name)", preferredStyle: .alert)
                                        let pokeDexAction = UIAlertAction(title: "Pokedex", style: .default, handler: { (action) in
                                            self.performSegue(withIdentifier: "moveToPokedex", sender: nil)
                                            
                                        })
                                        
                                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                                            alertVC.dismiss(animated: true, completion: nil)
                                        })
                                        
                                        alertVC.addAction(pokeDexAction)
                                        alertVC.addAction(okAction)
                                        present(alertVC, animated: true, completion: nil)
                                    }
                                    
                                }
                            }
                        } else {
                            // user can't catch
                            let alertVC = UIAlertController(title: "Out of Range", message: "You're out of range.. get closer!", preferredStyle: .alert)
                           
                            
                            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
                                alertVC.dismiss(animated: true, completion: nil)
                            })
                            
                            alertVC.addAction(okAction)
                            present(alertVC, animated: true, completion: nil)
                        }
                    }
                    
            }
        }
    }
    
    @IBAction func centerUserLocation(_ sender: Any) {
        if let coordinate = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 400, 400)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func generateRandomCoordinates() -> Double {
        return (Double(arc4random_uniform(200)) - 100.0)/50000.0
    }
}
