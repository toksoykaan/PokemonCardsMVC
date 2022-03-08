//
//  ViewController.swift
//  Pokemon Cards
//
//  Created by Kaan TOKSOY on 2.03.2022.
//

import UIKit


class ViewController: UIViewController {

    //MARK: Controller - Model Connection
    let modelManager = PokemonModelManager()
    
    
    //MARK: View - Controller Connection
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var hpOutlet: UILabel!
    @IBOutlet weak var attackOutlet: UILabel!
    @IBOutlet weak var defenceOutlet: UILabel!
    @IBOutlet weak var viewOutlet: UIView!
    @IBOutlet weak var imageOutlet: UIImageView!
    

    //We are going to use imageDict and infoArray to show retrieved data in View.
    var imageDict = [Int : UIImage]()
    var infoArray : [PokemonData] = []
    
    //This parameter shows which card we are on.
    var pokemonNumber = 1
    
    
    //Rotating animation constants
    let transformLayer = CATransformLayer()
    var currentAngle : CGFloat = 0
    var currentOffset : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewOutlet.layer.cornerRadius = 50
        
        //We are making a call to downloader method and save UIImages in a dictionary when the app's view loaded.
        DispatchQueue.main.async { [self] in
            modelManager.getPokemons()
            for i in 1...20{
                modelManager.imageDownloader(from: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(i).png")!) { [self] image in
                    imageDict[i] = image
                }
            }
        }
        
        //This function retrieves data from model and sets it at view it works async
        getSetParameters(pokeNumber: pokemonNumber)
        
        
        //MARK: Declaring card gesture recognizer to keep track of user input
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeLeft.direction = .left
            self.view.addGestureRecognizer(swipeLeft)
                
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)

        
        //User may not download the first item this function is a way out for image couldn't load
        if imageDict[1] == nil{
            modelManager.imageDownloader(from: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(1).png")!){ [self] image in
                imageOutlet.image = image
            }
        }
        
        
    }
    
    
    func getSetParameters(pokeNumber : Int){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            if infoArray.count == 0{
            infoArray = modelManager.pushPokemonArray()
            }
            
            imageOutlet.image = imageDict[pokeNumber]
            
            //We are substracting 1 because, we are using the same parameter as in ImageUrl which starts from check Line 35
            nameOutlet.text = infoArray[pokeNumber-1].name.capitalized
            hpOutlet.text = String(infoArray[pokeNumber-1].stats[1].base_stat)
            attackOutlet.text = String(infoArray[pokeNumber-1].stats[2].base_stat)
            defenceOutlet.text = String(infoArray[pokeNumber-1].stats[3].base_stat)
        }
    }
    

    
    //MARK: Here we declare the rules of swiping left and right, we will call for new card data as well as flipping animation
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) {
       if gesture.direction == .right {
           
           //At the end and start of the dict we need to jump from card 1 to 20 or 20 to 1. If else conditions lets us do that.
               if pokemonNumber != 1{
               pokemonNumber -= 1
               
                   getSetParameters(pokeNumber: pokemonNumber)
               }else{
                   pokemonNumber = 20
                   
                   getSetParameters(pokeNumber: pokemonNumber)
               }
           
           UIView.transition(with: viewOutlet, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
       }
       else if gesture.direction == .left {
        
               if pokemonNumber != 20{
               pokemonNumber += 1
              
               getSetParameters(pokeNumber: pokemonNumber)
               }else{
                   pokemonNumber = 1
                  
                   getSetParameters(pokeNumber: pokemonNumber)
               }
           
           UIView.transition(with: viewOutlet, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
       }
    }
    
    


    
}
