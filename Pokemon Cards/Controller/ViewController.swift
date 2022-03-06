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
    
    @IBOutlet weak var viewOutlet: UIView!
    
    @IBOutlet weak var imageOutlet: UIImageView!
    
    
    var pokemonNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewOutlet.layer.cornerRadius = 50
        
        
        modelManager.getPokemons(pokemonNumber: pokemonNumber)
        getSetParameters()

        
        
        //MARK: Declaring card gesture recognizer to keep track of user input
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
                
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
        
    }
    
    
    func getSetParameters(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in

            nameOutlet.text = modelManager.name?.capitalized
            hpOutlet.text = modelManager.hp
            attackOutlet.text = modelManager.attack
            defenceOutlet.text = modelManager.def
            
            modelManager.imageDownloader(from: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonNumber).png")!) { image in
                self.imageOutlet.image = image
            }
        }
    }
    
    
    
    
    //MARK: Here we declare the rules of swiping left and right, we will call for new card data as well as flipping animation
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
       if gesture.direction == .right {
           
               if pokemonNumber != 1{
               pokemonNumber -= 1
               modelManager.getPokemons(pokemonNumber: pokemonNumber)
               getSetParameters()
               }else{
                   pokemonNumber = 20
                   modelManager.getPokemons(pokemonNumber: pokemonNumber)
                   getSetParameters()
               }
           
           UIView.transition(with: viewOutlet, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
       }
       else if gesture.direction == .left {
        
               if pokemonNumber != 20{
               pokemonNumber += 1
               modelManager.getPokemons(pokemonNumber: pokemonNumber)
               getSetParameters()
               }else{
                   pokemonNumber = 1
                   modelManager.getPokemons(pokemonNumber: pokemonNumber)
                   getSetParameters()
               }
           
           UIView.transition(with: viewOutlet, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
       }
    }

    
}
