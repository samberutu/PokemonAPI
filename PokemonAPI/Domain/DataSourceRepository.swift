//
//  DataSourceRepository.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 30/01/23.
//

import Foundation
import Combine

protocol DataSourceRepositoryProtocol {
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) -> AnyPublisher<T, NetworkError>
}

class DataSourceRepository: NetworkServicing {
    
    private let networkService: NetworkServicing
    
    internal init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    func request<T, E>(to endpoint: E, decodeTo model: T.Type) -> AnyPublisher<T, NetworkError> where T: Decodable, E: Endpoint {
        networkService.request(to: endpoint, decodeTo: model)
    }
}
