//
//  PokemonViewModel.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import Foundation

class PokemonoViewModel {
    private var apiService = APIService()
    var pokemon = [Results]()
    var isLoading: Bool = false
    var pokemonTotalCount : Int?
    var next : String?
    var previous : String?
    private var filtered: [String]!
    
    func fetchMovieData(offset: String, completion: @escaping (PokemonModel) -> Void) {
        apiService.fetchAllPokemon(offset: offset ){ [ weak self] (result) in
            switch result {
            case .success(let listOf):
                self?.isLoading = false
                self?.pokemon = listOf.results
                self?.pokemonTotalCount = listOf.count
                self?.next = listOf.next
                self?.previous = listOf.previous
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
    func cellForRowAt (indexPath : IndexPath) -> Results {
        return pokemon[indexPath.row]
    }
}
