//
//  NetworkError.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 30/01/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURLRequest
    case noResponse
    case decoding
    case unauthorized
    case underlying(Error)
}
