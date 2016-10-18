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
    
    var loadingView: LoadingOverlay?
    
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
        
        self.loadingView = LoadingOverlay()
        self.loadingView?.showOverlay(view: self.view)
        
        self.pokemon.downloadData {
            self.updateUI()
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI() {
        self.mainImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
        self.firstImage.image = UIImage(named: "\(self.pokemon.pokedexID)")
        self.pokedexIDLabel.text = "\(self.pokemon.pokedexID)"
        self.baseAttackLabel.text = self.pokemon.attack
        self.heightLabel.text = self.pokemon.height
        self.weightLabel.text = self.pokemon.weight
        self.defenseLabel.text = self.pokemon.defense
        self.typeLabel.text = self.pokemon.type
        self.descriptionLabel.text = self.pokemon.description
        self.nextEvolutionLabel.text = self.nextEvolutionLabel.text?.appending(self.pokemon.nextEvolutionText)
        self.secondImage.image = UIImage(named: "\(self.pokemon.nextEvolutionID == "" ? "none" : self.pokemon.nextEvolutionID)")
        
        self.loadingView?.hideOverlayView()
    }

}
