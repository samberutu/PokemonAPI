//
//  PKMDetailViewModel.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 01/02/23.
//

import Foundation
import Combine
import SwiftUI

class PKMDetailViewModel: ObservableObject {
    @Published var pokemonDetail = PKMDetailModel.seeder
    @Published var isLoadData = false
    @Published var errorMessage = "Loading.."
    @Published var pkmDescription = "Description"
    
    private let networkRepository: NetworkServicing
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkRepository: NetworkServicing = DataSourceRepository()) {
        self.networkRepository = networkRepository
    }
    
    func fetchPKMDetail(pkmId: String) {
        isLoadData.toggle()
        let endpoint = FetchPokemonEndpoint(pokemonEndpoint: .getPKMDetail(id: pkmId))
        networkRepository.request(to: endpoint, decodeTo: PKMDetailModel.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("sucess fetch pkm detail")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoadData.toggle()
                }
            } receiveValue: { response in
                self.pokemonDetail = response
                self.fetchPKMDescription()
            }
            .store(in: &cancellables)
    }
    
    func fetchPKMDescription() {
        let endpoint = FetchPokemonEndpoint(pokemonEndpoint: .getPokemonDesc(id: String(pokemonDetail.id)))
        networkRepository.request(to: endpoint, decodeTo: PKMFlavorTextEntries.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finis pkm description")
                    self.isLoadData.toggle()
                case .failure(let error):
                    print("Fail pkm decription \(error.localizedDescription)")
                }
            } receiveValue: { species in
                self.getRandomDescription(descriptions: species.flavorTextEntries)
            }
            .store(in: &cancellables)
    }
    
    func getRandomDescription(descriptions: [FlavorTextEntry]) {
        let englishDesc = descriptions.filter { $0.language.name.contains("en") }
        guard englishDesc.count > 1 else { return }
        pkmDescription = englishDesc[Int.random(in: 0..<englishDesc.count)].flavorText
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\\", with: " ")
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
