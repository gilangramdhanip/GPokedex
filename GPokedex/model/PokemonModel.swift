//
//  PokemonModel.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import Foundation

// MARK: - PokemonModel
struct PokemonModel: Codable {
    let count: Int
    let next, previous: String?
    let results: [Results]
}

// MARK: - Result
struct Results: Codable {
    let name: String
    let url: String
}


