//
//  PKMSpeciesModel.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 01/02/23.
//

import Foundation

struct PKMFlavorTextEntries: Decodable {
    
    let flavorTextEntries: [FlavorTextEntry]
    
    enum CodingKeys: String, CodingKey {
            case flavorTextEntries = "flavor_text_entries"
        }
}

// MARK: - FlavorTextEntry
struct FlavorTextEntry: Decodable {
    let flavorText: String
    let language: DescriptionProprty

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

// MARK: - Color
struct DescriptionProprty: Decodable {
    let name: String
    let url: String
}
