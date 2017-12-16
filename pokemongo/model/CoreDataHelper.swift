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
    createPokemon(name: "Pikachu", imageName: "pikachu-2")
    createPokemon(name: "Eevee", imageName: "eevee")
    createPokemon(name: "Mankey", imageName: "mankey")
    createPokemon(name: "Psyduck", imageName: "psyduck")
    createPokemon(name: "Rattata", imageName: "rattata")
    createPokemon(name: "Snorlax", imageName: "snorlax")
    createPokemon(name: "Squirtle", imageName: "squirtle")
    createPokemon(name: "Venonat", imageName: "venonat")
    createPokemon(name: "Weedle", imageName: "weedle")
    createPokemon(name: "Zubat", imageName: "zubat")
    
}


func createPokemon(name: String, imageName: String) {
    
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        
        let pocketMonster = Pokemon(entity: Pokemon.entity(), insertInto: context)
        pocketMonster.name = name
        pocketMonster.imageName = imageName
        try? context.save()
    }
    
}

func getAllPokemon() -> [Pokemon] {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        
        if let pokeData = try? context.fetch(Pokemon.fetchRequest()) as? [Pokemon] {
            if let pocketMonsters = pokeData {
                
                if pocketMonsters.count == 0 {
                    addAllPokemon()
                    return getAllPokemon()
                }
                return pocketMonsters
            }
        }
    }
    return []
}

func getCaughtOrUnCaughtPokemon(caught: Bool) -> [Pokemon] {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
       
        let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        // find any pokemon that caught is equal to true
        fetchRequest.predicate = NSPredicate(format: "caught == %@", caught as CVarArg)
        if let pocketMonsters = try? context.fetch(fetchRequest) {
            return pocketMonsters
        }
    }
    return []
}

