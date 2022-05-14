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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var deffenseValue: UILabel!
    var orderID : Results?
    var listForm : String?
    var pokemonData : String?
    private var favPokemon : [Pokemon] = []
    @IBOutlet weak var favButton: UIBarButtonItem!
    private var isFavorite : Bool?
    private var dataPokemon : DetailPokemonModel?
    private var colorPokemon : PokemonColorModel?
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var transparentBackground: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var navbarItem: UINavigationItem!
    private var detailViewModel  = DetailPokemonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteButton.tintColor = .white
            
        transparentBackground.layer.cornerRadius = 10
        
        loadDetail()
        loadBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDetail()
        loadBar()
    }
    
    private func loadBar() {
        if detailViewModel.isLoading {
            favoriteButton.isEnabled = true
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
        } else {
            favoriteButton.isEnabled = false
            self.spinner.startAnimating()
            self.spinner.hidesWhenStopped = false
        }
    }
    
    func loadDetail(){
        favPokemon = PersitanceManager.shared.fetchFavoritPokemon()
                if listForm == "Dashboard" {
                    pokemonData = orderID?.url
                }
        
        for item in favPokemon {
        
            if item.url == pokemonData {
                if item.isFavorite == false {
                    isFavorite = true
                    favButton.image = UIImage(systemName: "heart")
                } else {
                    isFavorite = false
                    favButton.image = UIImage(systemName: "heart.fill")
                }
            }
        }
        
        detailViewModel.fetchDetailPokemonData(link: pokemonData!){ data in
            self.dataPokemon = data
            self.namePokemon.text = "\(data.name) #\(data.id)"
            self.imagePokemon.cacheImage(urlString: data.sprites.other?.home.frontDefault ?? "")
            self.hpValueLabel.text = "\(data.stats[0].baseStat )"
            self.attackValue.text = "\(data.stats[1].baseStat)"
            self.deffenseValue.text = "\(data.stats[2].baseStat)"
            self.typePokemon.text = "\u{200c} \(data.types[0].type.name) \u{200c}"
            
            
            self.detailViewModel.fetchPokemonColor(link: data.species.url) { moreData in
                self.favoriteButton.isEnabled = true
                self.spinner.stopAnimating()
                self.spinner.hidesWhenStopped = true
                
                let color = moreData.color.name
                self.colorPokemon = moreData
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
    
    
    @IBAction func favoritePressed(_ sender: Any) {
        
        if isFavorite == false {
            isFavorite = true
            favButton.image = UIImage(systemName: "heart")
            for item in favPokemon {
                if item.url == pokemonData {
                    PersitanceManager.shared.unFavoritePokemon(pokemon: item)
                    showToast(controller: self, message: "Removed favorite movie", seconds: 1.0, navigationController : navigationController!)
                }
            }
        } else {
            isFavorite = false
            favButton.image = UIImage(systemName: "heart.fill")
            PersitanceManager.shared.favoritePokemon(pokemonModel: dataPokemon!, isFavorite: true, pokemonColor: colorPokemon!, url : orderID!.url)
            showToast(controller: self, message: "Added favorite movie", seconds: 1.0, navigationController : navigationController!)
        }
        
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double, navigationController : UINavigationController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
            navigationController.popViewController(animated: true)
        }
    }
    
}
