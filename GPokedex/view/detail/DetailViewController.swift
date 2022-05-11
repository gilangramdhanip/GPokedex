//
//  DetailViewController.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var typePokemon: UILabel!
    @IBOutlet weak var hpValueLabel: UILabel!
    @IBOutlet weak var attackValue: UILabel!
    @IBOutlet weak var deffenseValue: UILabel!
    var orderID : Results?
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var transparentBackground: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    private var detailViewModel  = DetailPokemonViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteButton.tintColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        
        transparentBackground.layer.cornerRadius = 10

        detailViewModel.fetchDetailPokemonData(link: orderID?.url ?? ""){ data in
            
            self.namePokemon.text = data.name
            
            self.imagePokemon.cacheImage(urlString: data.sprites.other?.home.frontDefault ?? "")
            
            self.hpValueLabel.text = "\(data.stats[0].baseStat )"
            self.attackValue.text = "\(data.stats[1].baseStat)"
            self.deffenseValue.text = "\(data.stats[2].baseStat)"
                self.typePokemon.text = "\u{200c} \(data.types[0].type.name) \u{200c}"
            
            
            self.detailViewModel.fetchPokemonColor(link: data.species.url) { moreData in
                let color = moreData.color.name
                        if color == "green"{
                                self.backgroundView.backgroundColor = UIColor(named: "customGreen")
                            }else if color == "red"{
                                self.backgroundView.backgroundColor = UIColor(named: "customRed")
                            }else if color == "blue"{
                                self.backgroundView.backgroundColor = UIColor(named: "customBlue")
                            }else if color == "purple"{
                                self.backgroundView.backgroundColor = UIColor(named: "customPurple")
                            }else if color == "brown"{
                                self.backgroundView.backgroundColor = UIColor(named: "customBrown")
                            }else if color == "yellow"{
                                self.backgroundView.backgroundColor = UIColor(named: "customYellow")
                            }else{
                                self.backgroundView.backgroundColor = UIColor(named: "customLightGray")
                            }
            }
            

            
        }
    }

}
