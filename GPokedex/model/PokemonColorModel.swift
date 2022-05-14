//
//  PokemonColor.swift
//  GPokedex
//
//  Created by Gilang Ramdhani Putra on 12/05/22.
//

import Foundation

struct PokemonColorModel: Codable {
    let color: Color

    enum CodingKeys: String, CodingKey {
        case color
    }
    
}

struct Color: Codable {
    let name: String
    let url: String
}
