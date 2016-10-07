//
//  PokemonCell.swift
//  pokedex3
//
//  Created by Mason Prey on 10/6/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var pokemon: Pokemon?
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        
        self.name.text = pokemon.name.capitalized
        self.image.image = UIImage(named: "\(pokemon.pokeid)")
        
        self.contentView.layer.cornerRadius = 2.0
    }
    
}
