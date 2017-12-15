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
    
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // realize that the authorization is only in use
            mapView.showsUserLocation = true
        } else {
            manager.requestWhenInUseAuthorization()
        }
    }


}
