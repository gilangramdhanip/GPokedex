//
//  PokemonCollectionViewCell.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "pokemonCell"
    private var isCompleted : Bool = false
    
    private var detailViewModel  = DetailPokemonViewModel()
    
    static func nib()-> UINib {
        return UINib(nibName: "PokemonCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var numberPokemon: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var picImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        nameLabel.textColor = .white
        typeLabel.textColor = .white
        viewBackground.layer.cornerRadius = 10
        
        typeLabel.backgroundColor = UIColor(named: "customDarkGray")
        typeLabel.layer.cornerRadius = 5
        typeLabel.layer.masksToBounds = true
    }
    
    
    func setUpUIFavorite(pokemon : Pokemon){
        
        nameLabel.text = pokemon.name
        numberPokemon.text = "#\(pokemon.id ?? "0")"
        picImage.cacheImage(urlString: pokemon.image!)
        typeLabel.text = "\u{200c} \(pokemon.type ?? "") \u{200c}"
        if pokemon.color == "green"{
            viewBackground.backgroundColor = UIColor(named: "customGreen")
        }else if pokemon.color == "red"{
            viewBackground.backgroundColor = UIColor(named: "customRed")
        }else if pokemon.color == "blue"{
            viewBackground.backgroundColor = UIColor(named: "customBlue")
        }else if pokemon.color == "purple"{
            viewBackground.backgroundColor = UIColor(named: "customPurple")
        }else if pokemon.color == "brown"{
            viewBackground.backgroundColor = UIColor(named: "customBrown")
        }else if pokemon.color == "yellow"{
            viewBackground.backgroundColor = UIColor(named: "customYellow")
        }else{
            viewBackground.backgroundColor = UIColor(named: "customLightGray")
            
        }
        
    }
    
    
    func setUpUI(pokemon : Results){

        detailViewModel.fetchDetailPokemonData(link: pokemon.url) { data in
            self.nameLabel.text = " \(data.name) "
            self.numberPokemon.text = "#\(data.id)"
            self.picImage.cacheImage(urlString: data.sprites.other?.home.frontDefault ?? "")
            self.typeLabel.text = "\u{200c} \(data.types[0].type.name) \u{200c}"
            self.detailViewModel.fetchPokemonColor(link: data.species.url) { moreData in

                let color = moreData.color.name
                if color == "green"{
                    self.viewBackground.backgroundColor = UIColor(named: "customGreen")
                }else if color == "red"{
                    self.viewBackground.backgroundColor = UIColor(named: "customRed")
                }else if color == "blue"{
                    self.viewBackground.backgroundColor = UIColor(named: "customBlue")
                }else if color == "purple"{
                    self.viewBackground.backgroundColor = UIColor(named: "customPurple")
                }else if color == "brown"{
                    self.viewBackground.backgroundColor = UIColor(named: "customBrown")
                }else if color == "yellow"{
                    self.viewBackground.backgroundColor = UIColor(named: "customYellow")
                }else{
                    self.viewBackground.backgroundColor = UIColor(named: "customLightGray")
                }
            }
            
        }
    }
    
}
