//
//  NetworkService.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 30/01/23.
//

import Foundation
import Combine
import Alamofire

protocol NetworkServicing {
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) -> AnyPublisher<T, NetworkError>
}

class NetworkService: NetworkServicing {
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) -> AnyPublisher<T, NetworkError> {
        
        return Future<T, NetworkError> { completion in
            guard let myUrl = endpoint.urlRequest?.url else {
                completion(.failure(.invalidURLRequest))
                return
            }
            print(myUrl)
            AF.request(myUrl)
                .validate()
                .response { response in
                    switch response.result {
                    case .success(let value):
//                        #if DEBUG
//                        NetworkLogger.log(data: value ?? Data(), response: response.response!)
//                        #endif
                        guard response.response?.statusCode != 401 else {
                            return completion(.failure(.unauthorized))
                        }
                        
                        if let newDecode = try? JSONDecoder().decode(model.self, from: value ?? Data()) {
                            completion(.success(newDecode))
                        } else {
                            completion(.failure(.decoding))
                        }
                        
                    case .failure:
                        completion(.failure(.noResponse))
                    }

                }
            
        }
        .eraseToAnyPublisher()
    }
}
