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
    
    //We are delivering API data to this array at once. including PokemonData items
    var pokemonArray : [PokemonData] = []
    //Used in while loop at line 33 which where we append API data to pokemonArray
    var i = 1
    
    
    func getPokemons(){
        
        while i <= 20{
            url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(i)/")
            i+=1
        let task  = URLSession.shared.dataTask(with: url!) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async { [self] in
                do{
                    let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                    //We are appending data 20 times at APP startup
                    pokemonArray.append(pokemonData)
                    
                }catch{
                    print(error)
                }
            }
    }
        task.resume()
    }
    }
    
    
    //Standart image downloader with guard let URLResponse of 200.
    //Image is going to be downloaded 20 times as ViewController asks this helper method at ViewController section line 33
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

    func pushPokemonArray() -> [PokemonData]{
        return pokemonArray
    }
    

}
