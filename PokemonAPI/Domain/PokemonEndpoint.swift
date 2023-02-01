//
//  PokemonEndpoint.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 30/01/23.
//

import Foundation

enum PokemonEndpoint {
    case getPKMDetail(id: String)
    case getPKMList(offset: Int, limit: Int)
    case getPokemonDesc(id: String)
}

extension PokemonEndpoint: Endpoint {
    
    var host: String {
        return "pokeapi.co"
    }
    
    var path: String {
        switch self {
            
        case .getPKMDetail(id: let id):
            return "/api/v2/pokemon/\(id)"
        case .getPKMList:
            return "/api/v2/pokemon"
        case .getPokemonDesc(id: let id):
            return "/api/v2/pokemon-species/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        case .getPKMDetail:
            return .get
        case .getPKMList:
            return .get
        case .getPokemonDesc:
            return .get
        }
    }
    
    var body: [URLQueryItem]? {
        switch self {
            
        case .getPKMDetail:
            return []
        case .getPKMList(offset: let offset, limit: let limit):
            return [
                URLQueryItem(name: "offset", value: String(offset)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
        case .getPokemonDesc:
            return []
        }
    }
    
}
