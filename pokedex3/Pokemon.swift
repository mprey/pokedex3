//
//  Pokemon.swift
//  pokedex3
//
//  Created by Mason Prey on 10/6/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import Foundation

class Pokemon {
    
    var _name: String!
    var _pokeid: Int!
    
    var name: String {
        return self._name
    }
    
    var pokeid: Int {
        return self._pokeid
    }
    
    init(name: String, pokeid: Int) {
        self._name = name
        self._pokeid = pokeid
    }
    
}

