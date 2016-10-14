//
//  Pokemon.swift
//  pokedex3
//
//  Created by Mason Prey on 10/6/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String?
    private var _type: String?
    private var _defense: String?
    private var _height: String?
    private var _weight: String?
    private var _attack: String?
    private var _nextEvolutionText: String?
    private var _pokeapiURL: String!

    
    var name: String {
        return self._name
    }
    
    var pokedexID: Int {
        return self._pokedexID
    }
    
    init(name: String, pokeid: Int) {
        self._name = name
        self._pokedexID = pokeid
        
        self._pokeapiURL = "\(kMPBaseURL)\(kMPPokeURL)\(self._pokedexID)!"
    }
    
    func downloadData(completed: DownloadComplete) {
        let url = URL(string: self._pokeapiURL)!
        print(url, "\n\n\n\n\n\n\n")
        Alamofire.request(url).responseJSON { response in
            print(response)
        }
    }
}

