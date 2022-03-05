//
//  ViewController.swift
//  Pokemon Cards
//
//  Created by Kaan TOKSOY on 2.03.2022.
//

import UIKit

class ViewController: UIViewController {

    let modelManager = PokemonModelManager()
    
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var hpOutlet: UILabel!
    @IBOutlet weak var attackOutlet: UILabel!
    @IBOutlet weak var defenceOutlet: UILabel!
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modelManager.getPokemons(pokemonNumber: 1)
        getParameters()
        modelManager.imageDownloader(from: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!) { image in
            self.imageOutlet.image = image
        }
    }
    
    func getParameters(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            nameOutlet.text = modelManager.name
            hpOutlet.text = modelManager.hp
            attackOutlet.text = modelManager.attack
            defenceOutlet.text = modelManager.def
        }
}

}
