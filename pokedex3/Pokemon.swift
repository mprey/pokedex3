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
    
    var description: String {
        if self._description == nil {
            self._description = ""
        }
        return self._description!
    }
    
    var type: String {
        if self._type == nil {
            self._type = ""
        }
        return self._type!
    }
    
    var defense: String {
        if self._defense == nil {
            self._defense = ""
        }
        return self._defense!
    }
    
    var height: String {
        if self._height == nil {
            self._height = ""
        }
        return self._height!
    }
    
    var weight: String {
        if self._weight == nil {
            self._weight = ""
        }
        return self._weight!
    }
    
    var attack: String {
        if self._attack == nil {
            self._attack = ""
        }
        return self._attack!
    }
    
    var nextEvolutionText: String {
        if self._nextEvolutionText == nil {
            self._nextEvolutionText = ""
        }
        return self._nextEvolutionText!
    }
    
    init(name: String, pokeid: Int) {
        self._name = name
        self._pokedexID = pokeid
        
        self._pokeapiURL = "\(kMPBaseURL)\(kMPPokeURL)\(self._pokedexID!)"
    }
    
    func downloadData(completed: DownloadComplete) {
        let url = URL(string: self._pokeapiURL)!
        Alamofire.request(url).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let attack = dict["attack"] as? String {
                    self._attack = attack
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let defense = dict["defense"] as? String {
                    self._defense = defense
                }
            }
            completed()
        }
    }
}

