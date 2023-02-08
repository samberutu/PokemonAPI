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
    func networkErrorHandle(statusCode: Int) -> NetworkError
}

class NetworkService: NSObject {
    
    private override init() { }
    
    static let sharedInstance: NetworkService = NetworkService()
}

extension NetworkService: NetworkServicing {
    
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) -> AnyPublisher<T, NetworkError> {
        
        return Future<T, NetworkError> { completion in
            guard let myUrl = endpoint.urlRequest?.url else {
                completion(.failure(.invalidURLRequest))
                return
            }
            AF.request(myUrl)
                .validate()
                .response { response in
                    switch response.result {
                    case .success(let value):
                        guard let response = response.response else {
                            return completion(.failure(.noResponse))
                        }
//                        #if DEBUG
//                        NetworkLogger.log(data: value ?? Data(), response: response.response!)
//                        #endif
                        guard response.statusCode != 401 else {
                            return completion(.failure(.unauthorized))
                        }
            
                        guard let decodeData = try? JSONDecoder().decode(model.self, from: value ?? Data()) else {
                            return completion(.failure(.decoding))
                        }
                        completion(.success(decodeData))
                        
                    case .failure:
                        completion(.failure(.underlying(response.error!)))
                    }

                }
            
        }
        .eraseToAnyPublisher()
    }
    
    func networkErrorHandle(statusCode: Int) -> NetworkError {
        
        return .unauthorized
    }
}
