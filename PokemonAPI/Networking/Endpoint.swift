//
//  Endpoint.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 30/01/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [URLQueryItem]? { get }
}

extension Endpoint {
    var method: HTTPMethod { .get }
    var header: [String: String]? { nil }
    var body: [String: Any]? { nil }

    var urlRequest: URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = body

        guard let url = urlComponents.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header
        
        return urlRequest
    }

}
