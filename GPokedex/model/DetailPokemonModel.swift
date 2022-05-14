//
//  DetailPokemon.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 10/05/22.
//

import Foundation

// MARK: - MoviesReview
struct DetailPokemonModel: Codable {
    let id: Int
    let name: String
    let order: Int
    let species: Species
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name, order
        case species, sprites, stats, types, weight
    }
}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}

// MARK: - Sprites
class Sprites: Codable {
    let frontDefault: String
    let other: Other?
    let animated: Sprites?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other, animated
    }

    init(frontDefault: String, other: Other?, animated: Sprites?) {
        self.frontDefault = frontDefault
        self.other = other
        self.animated = animated
    }
}
// MARK: - Home
struct Home: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Other
struct Other: Codable {
    let home: Home

    enum CodingKeys: String, CodingKey {
        case home
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: Species
}
