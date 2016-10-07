//
//  ViewController.swift
//  pokedex3
//
//  Created by Mason Prey on 10/6/16.
//  Copyright © 2016 Mason Prey. All rights reserved.
//

import UIKit
import AVFoundation

class PokedexController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var pokemonCollection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    
    var musicPlayer: AVAudioPlayer!
    
    var searchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pokemonCollection.dataSource = self
        self.pokemonCollection.delegate = self
        self.searchBar.delegate = self
    
        self.registerPokemon()
        self.initAudio()
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do {
            self.musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            self.musicPlayer.prepareToPlay()
            self.musicPlayer.numberOfLoops = -1
            self.musicPlayer.play()
            
        } catch let err as NSError {
            print(err.description)
        }
    }
    
    func registerPokemon() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let men = Pokemon(name: row["identifier"]!, pokeid: Int(row["id"]!)!)
                self.pokemon.append(men)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMode ? self.filteredPokemon.count : self.pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = self.pokemonCollection.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokemonCell {
            let pokemon = searchMode ? self.filteredPokemon[indexPath.row] : self.pokemon[indexPath.row]
            cell.configureCell(pokemon)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText == "") {
            searchMode = false
        } else {
            searchMode = true
            let text = searchText.lowercased()
            self.filteredPokemon = pokemon.filter({$0.name.range(of: text) != nil})
            self.pokemonCollection.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
    }

    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if (self.musicPlayer.isPlaying) {
            self.musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            self.musicPlayer.play()
            sender.alpha = 1.0
        }
    }
}

