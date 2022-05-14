//
//  FavoriteViewController.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    private var favoriteList = [Pokemon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.register(PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        favoriteCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFavData()
    }
    
    func fetchFavData() {
        favoriteList = PersitanceManager.shared.fetchFavoritPokemon()
        self.favoriteCollectionView.reloadData()
    }
    
}

extension FavoriteViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: 168)
    }
}

extension FavoriteViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        cell.setUpUIFavorite(pokemon: favoriteList[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.pokemonData = favoriteList[indexPath.row].url
        vc.listForm = "Favorite"
        show(vc, sender: self)
    }
    
}
