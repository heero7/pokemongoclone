//
//  CoreDataHelper.swift
//  pokemongo
//
//  Created by Kevin Mudiandambo on 12/15/17.
//  Copyright © 2017 Kevin Mudiandambo. All rights reserved.
//

import UIKit
import CoreData


func addAllPokemon() {
    
}


func createPokemon(name: String, imageName: String) {
    
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        
        let pocketMonster = Pokemon(entity: Pokemon.entity(), insertInto: context)
        pocketMonster.name = name
        pocketMonster.imageName = imageName
        
        try? context.save()
    }
    
}
