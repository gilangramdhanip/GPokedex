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
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var picImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setUpUI(pokemon : Results){
        
        nameLabel.textColor = .white
        typeLabel.textColor = .white
        viewBackground.layer.cornerRadius = 10

        typeLabel.backgroundColor = UIColor(named: "customDarkGray")
        typeLabel.layer.cornerRadius = 5
        typeLabel.layer.masksToBounds = true

        
        nameLabel.text = " \(pokemon.name) "
        detailViewModel.fetchDetailPokemonData(link: pokemon.url) { data in
                
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
