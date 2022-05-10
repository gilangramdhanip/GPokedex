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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setUpUI(pokemon : Results){
        nameLabel.text = pokemon.name
        detailViewModel.fetchDetailMovieData(link: pokemon.url) { data in
            DispatchQueue.main.async {
                
            self.picImage.cacheImage(urlString: data.sprites.other?.home.frontDefault ?? "")
                
            }
        }
        viewBackground.backgroundColor = .blue
        
    }

}
