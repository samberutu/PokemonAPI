//
//  PKMDetailModel.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 31/01/23.
//

import Foundation

// MARK: - PokemonDetail
struct PKMDetailModel: Decodable {
    let height: Int
    let id: Int
    let moves: [Move]
    let name: String
    let stats: [Stat]
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int

}

// MARK: - Ability
struct Ability: Decodable {
    let ability: Species
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

// MARK: - Species
struct Species: Decodable {
    let name: String
    let url: String
}

// MARK: - GameIndex
struct GameIndex: Decodable {
    let gameIndex: Int
    let version: Species

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}

// MARK: - Move
struct Move: Decodable {
    let move: Species
}

// MARK: - Stat
struct Stat: Decodable {
    let baseStat, effort: Int
    let stat: Species
    
    static let seeder = Stat(baseStat: 0,
                             effort: 0,
                             stat: Species(name: "",
                                           url: ""))

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement: Decodable {
    let slot: Int
    let type: Species
}

// MARK: - Sprites
class Sprites: Decodable {
    let other: Other
    init(other: Other) {
        self.other = other
    }
}

// MARK: - Other
struct Other: Decodable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Decodable {
    let frontDefault, frontShiny: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

extension PKMDetailModel {
    static let seeder = PKMDetailModel(height: 0,
                                       id: 0,
                                       moves: [],
                                       name: "",
                                       stats: [],
                                       sprites: Sprites(other: Other(officialArtwork: OfficialArtwork(frontDefault: "",
                                                                                                      frontShiny: ""))),
                                       types: [],
                                       weight: 0)
}
