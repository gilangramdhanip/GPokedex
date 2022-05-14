//
//  DashboardViewController.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var buttonPrevious: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var dashboardTableView: UICollectionView!
    @IBOutlet weak var numberPage: UIButton!
    private var pokemonViewModel = PokemonoViewModel()
    private var searchFilteredPokemon = [Results]()
    var tampungOffset = 0
    var tampungPage = 1
    
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
        buttonPrevious.isEnabled = false
        dashboardTableView.setCollectionViewLayout(layout, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changePageNumber(numberPageCount: tampungPage)
        loadPokemonList(offset: "\(tampungOffset)")
        loadBar()
    }
    
    func changePageNumber(numberPageCount : Int){
        numberPage.setTitle("Page \(numberPageCount)", for: .normal)
        numberPage.isUserInteractionEnabled = false
        
    }
    
    
    private func loadBar() {
        if pokemonViewModel.isLoading {
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
        } else {
            self.spinner.startAnimating()
            self.spinner.hidesWhenStopped = false
        }
    }
    
    
    private func loadPokemonList(offset : String){
        pokemonViewModel.fetchMovieData(offset: offset){ data in
            
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
            DispatchQueue.main.async {
                self.dashboardTableView.reloadData()
            }
        }
    }
    @IBAction func favPagePressed(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Favorite", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "favoriteViewController") as! FavoriteViewController
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
    
    @IBAction func buttonNextPressed(_ sender: Any) {
        
        if ((pokemonViewModel.next?.isEmpty) != nil) {
            buttonPrevious.isEnabled = true
            buttonNext.isEnabled = true
            tampungPage = tampungPage + 1
            tampungOffset = tampungOffset + 20
            changePageNumber(numberPageCount: tampungPage)
            loadPokemonList(offset: "\(tampungOffset)")
            loadBar()
            
            let lastPage = Double(pokemonViewModel.pokemonTotalCount!) / 20.0
            
            if tampungPage == Int(lastPage.rounded(.up)) {
                buttonNext.isEnabled = false
            }
        }else{
            buttonNext.isEnabled = false
        }
    }
    
    @IBAction func buttonPrevPressed(_ sender: Any) {
        if ((pokemonViewModel.previous?.isEmpty) != nil) {
            buttonNext.isEnabled = true
            tampungPage = tampungPage - 1
            tampungOffset = tampungOffset - 20
            changePageNumber(numberPageCount: tampungPage)
            loadPokemonList(offset: "\(tampungOffset)")
            loadBar()
            
            if tampungPage == 1 {
                buttonPrevious.isEnabled = false
            }
        }else{
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
        return CGSize(width: widthPerItem - 8, height: 168)
    }
}

extension DashboardViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
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
        vc.listForm = "Dashboard"
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
}
