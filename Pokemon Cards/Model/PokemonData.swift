//
//  PokemonModel.swift
//  Pokemon Cards
//
//  Created by Kaan TOKSOY on 5.03.2022.
//

import Foundation


// MARK: About API

// Analyzing the API deliver images and name/stat seperately. We are going to use URL downloader in PokemonModelManager.

// Main URL : https://pokeapi.co/api/v2/pokemon/n/ -> n will declare pokemon's individual urls

// name : name

// IMG URL : "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/n.png" index is 1 2 3.png etc.

// STATS
// hp stats[0].base_stat
// attack  stats[1].base_stat
// def stats[2].base_stat

struct PokemonData : Decodable{
    var name : String
    var stats : [Stats]
}

struct Stats : Decodable {
    let base_stat : Int
}





