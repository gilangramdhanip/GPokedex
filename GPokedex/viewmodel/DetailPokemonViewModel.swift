//
//  DetailPokemonViewModel.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import Foundation

class DetailPokemonViewModel {
    private var apiService = APIService()
    private var pokemon = [DetailPokemonModel]()
    var isLoading: Bool = false
    func fetchDetailPokemonData(link : String, completion: @escaping (DetailPokemonModel) -> Void) {
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
    
    func fetchPokemonColor(link : String, completion: @escaping (PokemonColorModel) -> Void) {
        apiService.getColorPokemon(link: link) { [ weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.isLoading = false
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
    func cellForRowAt (indexPath : IndexPath) -> DetailPokemonModel {
        return pokemon[indexPath.row]
    }
}
