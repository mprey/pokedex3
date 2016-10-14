//
//  DetailViewController.swift
//  pokedex3
//
//  Created by Mason Prey on 10/7/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var nextEvolutionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pokemonLabel.text = self.pokemon.name.capitalized
        
        self.pokemon.downloadData {
            self.updateUI()
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        //TODO
    }

}
