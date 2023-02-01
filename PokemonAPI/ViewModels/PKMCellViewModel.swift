//
//  PKMCellViewModel.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 31/01/23.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class PKMCellViewModel {
    private let networkRepository: NetworkServicing
    private var cancellables: Set<AnyCancellable> = []
    
    var pokemonDetail: PKMDetailModel = PKMDetailModel.seeder
    
    init(networkRepository: NetworkServicing = DataSourceRepository()) {
        self.networkRepository = networkRepository
    }
    
    func fetchPKMDetail(id: String, action: @escaping () -> Void) {
        let endpoint = FetchPokemonEndpoint(pokemonEndpoint: .getPKMDetail(id: id))
        networkRepository.request(to: endpoint, decodeTo: PKMDetailModel.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                    
                case .finished:
                    #if DEBUG
                    print("finish")
                    #endif
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                self.pokemonDetail = response
                action()
            }
            .store(in: &cancellables)
    }
    
    func addProgressImage() -> UIImage? {
        let progressImage = UIImage(systemName: "hourglass.bottomhalf.filled")
        progressImage?.withTintColor(.red, renderingMode: .alwaysOriginal)
        return progressImage
    }
    
    func getTypeColor() -> UIColor {
        let types = pokemonDetail.types.map { $0.type }
        guard let firstIndex = types.first else { return UIColor(ColorManager.PKMNormal) }
        let pkmType = PKMType.allCases.filter { $0.rawValue == firstIndex.name }.first
        guard let type = pkmType?.typeColor else { return UIColor(ColorManager.PKMNormal) }
        return UIColor(type)
    }
    
    func getTypesColor() -> [Color] {
        let types = pokemonDetail.types.map { $0.type }
        let colors = types.map { type in
            return UIColor(PKMType.allCases.filter { $0.rawValue == type.name }.first?.typeColor ?? ColorManager.PKMNormal)
        }
        return colors.map { Color($0) }
    }
    
    func getMoves() -> [String] {
        guard pokemonDetail.moves.count > 2 else { return [] }
        return pokemonDetail.moves[0...1].map { $0.move.name }
    }
    
    func getStatTitle() -> [String] {
        let statsTitle = pokemonDetail.stats.map { $0.stat.name }
        let convertedTitle: [String] = statsTitle.map { stat in
            return PKMStatsManager.allCases.filter { $0.rawValue == stat }.first?.statType ?? stat
        }
        
        return convertedTitle
    }
}
