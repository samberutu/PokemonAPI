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

extension NetworkError {
    var errorMessage: String {
        switch self {
            
        case .invalidURLRequest:
            return "there was an error in this application"
        case .noResponse:
            return "Please make sure you filled in the all the required fields."
        case .decoding:
            return "there was an error in this application"
        case .unauthorized:
            return "please re-login"
        case .underlying( let error):
            return "there was an error in your application\n\(error.localizedDescription)"
        }
    }
}
