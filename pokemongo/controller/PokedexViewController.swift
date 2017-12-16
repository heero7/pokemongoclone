//
//  PokedexViewController.swift
//  pokemongo
//
//  Created by Kevin Mudiandambo on 12/15/17.
//  Copyright © 2017 Kevin Mudiandambo. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var pokedexTableView: UITableView!
    
    
    var caughtPokemon : [Pokemon] = []
    var uncaughtPokemon : [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        caughtPokemon = getCaughtOrUnCaughtPokemon(caught: true)
        uncaughtPokemon = getCaughtOrUnCaughtPokemon(caught: false)
        
        pokedexTableView.dataSource = self
        pokedexTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return caughtPokemon.count
        } else {
            return uncaughtPokemon.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        var pokemon : Pokemon
        if indexPath.section == 0 {
            pokemon = caughtPokemon[indexPath.row]
        } else {
            pokemon = uncaughtPokemon[indexPath.row]
        }
        
        if let pokemonImage = pokemon.imageName {
            cell.imageView?.image = UIImage(named: pokemonImage)
        }
        cell.textLabel?.text = pokemon.name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            // show caught pokemon
            return "CAUGHT"
        } else {
            return "UNCAUGHT"
        }
    }
    
    @IBAction func returnToMapView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
