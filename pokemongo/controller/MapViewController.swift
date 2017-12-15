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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // realize that the authorization is only in use
            mapView.showsUserLocation = true
            // ask for current location, continually update
            manager.startUpdatingLocation()
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }

    /*
     We'll make sure the app starts zoomed in to the current location of the phone
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // play with this count to get the right location
        
        if updateCount < 3 {
            
            if let coordinate = manager.location?.coordinate {
                let region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
                mapView.setRegion(region, animated: false)
            }
            
            updateCount += 1
        }
        
        
        
    }
}
