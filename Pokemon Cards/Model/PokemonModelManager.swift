//
//  PokemonModelManager.swift
//  Pokemon Cards
//
//  Created by Kaan TOKSOY on 5.03.2022.
//

import Foundation
import UIKit


class PokemonModelManager{
    //using url as a
    var url : URL?
    
    //creating variables to pass into ViewController after JSONDecoder function is completed
    var name : String?
    var hp : String?
    var attack : String?
    var def : String?
    
    //UIImage Downloader input
    var image : UIImage?
    
    
    func getPokemons(pokemonNumber : Int){
        
        url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonNumber)/")
        let task  = URLSession.shared.dataTask(with: url!) { data, _, error in
            guard let data = data, error == nil else {
                print("loading")
                return
            }
            DispatchQueue.main.async { [self] in
                do{
                    let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                    
                    name = pokemonData.name
                    hp = String(pokemonData.stats[0].base_stat)
                    attack = String(pokemonData.stats[1].base_stat)
                    def = String(pokemonData.stats[2].base_stat)
                    
                }catch{
                    print(error)
                }
            }
    }
        task.resume()
    }
    
    func imageDownloader(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, completion: ((UIImage) -> Void)?) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {
                completion?(image)
            }
        }.resume()
    }


}
