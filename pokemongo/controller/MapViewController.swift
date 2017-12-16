//
//  MapViewController.swift
//  pokemongo
//
//  Created by Kevin Mudiandambo on 12/14/17.
//  Copyright © 2017 Kevin Mudiandambo. All rights reserved.
//

import UIKit
import MapKit   // necessary for having the MKMapView

class MapViewController: UIViewController, CLLocationManagerDelegate {

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
        } else {
            manager.requestWhenInUseAuthorization()
        }
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if let center = self.manager.location?.coordinate {
                let annotation = MKPointAnnotation()
                var annoCord = center
                annoCord.latitude += self.generateRandomCoordinates()
                annoCord.longitude += self.generateRandomCoordinates()
                annotation.coordinate = annoCord
                self.mapView.addAnnotation(annotation)
            }
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
