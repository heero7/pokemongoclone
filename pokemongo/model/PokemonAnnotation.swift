//
//  PokemonAnnotation.swift
//  pokemongo
//
//  Created by Kevin Mudiandambo on 12/16/17.
//  Copyright © 2017 Kevin Mudiandambo. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var pokemon : Pokemon
    
    
    init(coord:CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coord
        self.pokemon = pokemon
    }
}
