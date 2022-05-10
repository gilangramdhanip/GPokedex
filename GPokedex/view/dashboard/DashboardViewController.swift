//
//  DashboardViewController.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var dashboardTableView: UICollectionView!
    private var pokemonViewModel = PokemonoViewModel()

    private var saveImageUrl : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dashboardTableView.register(PokemonCollectionViewCell.nib(), forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        dashboardTableView.delegate = self
        dashboardTableView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        
        //Call Gallery Collection cell
        dashboardTableView.setCollectionViewLayout(layout, animated: true)
        loadPokemonList(offset: "0")
    }
    
    
    private func loadPokemonList(offset : String){
        pokemonViewModel.fetchMovieData(offset: offset){ _ in
                    DispatchQueue.main.async {
                        self.dashboardTableView.reloadData()
                    }
        }
    }

}

extension DashboardViewController : UICollectionViewDelegateFlowLayout{
    
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
                return CGSize(width: widthPerItem - 8, height: 250)
        }
}

extension DashboardViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonViewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dashboardTableView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
            cell.setUpUI(pokemon: pokemonViewModel.cellForRowAt(indexPath: indexPath))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        vc.orderID = pokemonViewModel.cellForRowAt(indexPath: indexPath)
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
    
}
