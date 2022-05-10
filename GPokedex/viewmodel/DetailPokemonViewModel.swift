//
//  DetailPokemonViewModel.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import Foundation

class DetailPokemonViewModel {
    private var apiService = APIService()
    private var pokemon = [DetailPokemon]()
    var isLoading: Bool = false
    func fetchDetailMovieData(link : String, completion: @escaping (DetailPokemon) -> Void) {
        apiService.getDetailPokemon(link: link) { [ weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.isLoading = false
                self?.pokemon = [listOf]
                completion(listOf)
            case.failure(let error):
                self?.isLoading = true
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if pokemon.count != 0 {
            return pokemon.count
        }
        return 0
    }
    func cellForRowAt (indexPath : IndexPath) -> DetailPokemon {
        return pokemon[indexPath.row]
    }
}