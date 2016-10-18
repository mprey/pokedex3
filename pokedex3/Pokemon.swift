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
    
    private var _name: String! //done
    private var _pokedexID: Int! //done
    private var _description: String? //done
    private var _type: String? //done
    private var _defense: String? //done
    private var _height: String? //done
    private var _weight: String? //done
    private var _attack: String? //done
    private var _nextEvolutionText: String?
    private var _nextEvolutionID: String? //done
    private var _nextEvolutionLevel: String? //done
    private var _nextEvolutionName: String? //done
    private var _pokeapiURL: String! //done
    
    var name: String {
        return self._name
    }
    
    var pokedexID: Int {
        return self._pokedexID
    }
    
    var nextEvolutionID: String {
        if self._nextEvolutionID == nil {
            self._nextEvolutionID = ""
        }
        return self._nextEvolutionID!
    }
    
    var nextEvolutionLevel: String {
        if self._nextEvolutionLevel == nil {
            self._nextEvolutionLevel = ""
        }
        return self._nextEvolutionLevel!
    }
    
    var nextEvolutionName: String {
        if self._nextEvolutionName == nil {
            self._nextEvolutionName = ""
        }
        return self._nextEvolutionName!
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
            if (self.nextEvolutionName == "" || self.nextEvolutionLevel == "") {
                self._nextEvolutionText = "None"
            } else {
                self._nextEvolutionText = "\(self.nextEvolutionName) LVL \(self.nextEvolutionLevel)"
            }
        }
        return self._nextEvolutionText!
    }
    
    init(name: String, pokeid: Int) {
        self._name = name
        self._pokedexID = pokeid
        
        self._pokeapiURL = "\(kMPBaseURL)\(kMPPokeURL)\(self._pokedexID!)"
    }
    
    func downloadData(completed: @escaping DownloadComplete) {
        let url = URL(string: self._pokeapiURL)!
        Alamofire.request(url).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let typeDict = dict["types"] as? [Dictionary<String, AnyObject>], typeDict.count > 0 {
                    self._type = typeDict[0]["name"]?.capitalized
                    
                    for index in 1..<typeDict.count {
                        self._type?.append("/\(typeDict[index]["name"]!.capitalized!)")
                    }
                }
                
                if let evolutionDict = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutionDict.count > 0 {
                    if let nextEvolution = evolutionDict[0]["to"] as? String {
                        if nextEvolution.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvolution
                            
                            if let uri = evolutionDict[0]["resource_uri"] as? String {
                                let evoID = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "").replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionID = evoID
                            }
                            
                            if let level = evolutionDict[0]["level"] as? Int {
                                self._nextEvolutionLevel = "\(level)"
                            }
                        }
                    }
                }
                
                if let descDict = dict["descriptions"] as? [Dictionary<String, AnyObject>] {
                    let descriptionURL = "\(kMPBaseURL)\(descDict[0]["resource_uri"]!)"
                    Alamofire.request(URL(string: descriptionURL)!).responseJSON { response1 in
                        if let dict1 = response1.result.value as? Dictionary<String, AnyObject> {
                            if let description = dict1["description"] as? String {
                                self._description = description
                            }
                        }
                        completed()
                    }
                }
            }
        }
    }
}

