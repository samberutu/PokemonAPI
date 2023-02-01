//
//  Response.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 30/01/23.
//

import Foundation

struct PKMListResponse<T: Decodable>: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [T]
}

struct EmptyData: Decodable {}
