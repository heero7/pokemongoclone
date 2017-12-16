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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pokedexTableView.dataSource = self
        pokedexTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "Pikachu!"
        
        return cell
    }
    
    

    
    @IBAction func returnToMapView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
