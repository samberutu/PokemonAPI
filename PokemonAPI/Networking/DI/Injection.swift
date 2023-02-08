//
//  Injection.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 07/02/23.
//

import Foundation

final class Injection {
    private func provideRepository() -> DataSourceRepositoryProtocol {
        let networkService: NetworkService = NetworkService.sharedInstance
        return DataSourceRepository.sharedInstance(networkService)
    }
    
    func provideHomeView() -> PKMHomeViewModel {
        let repository = self.provideRepository()
        let viewModel = PKMHomeViewModel(networkRepository: repository)
        return viewModel
    }
    
    func provideCellRepository() -> PKMCellViewModel {
        let repository = self.provideRepository()
        let cellViewModel = PKMCellViewModel(networkRepository: repository)
        return cellViewModel
    }
    
    func providePKMDetailViewModel() -> PKMDetailViewModel {
        let repository = self.provideRepository()
        let detailViewModel = PKMDetailViewModel(networkRepository: repository)
        return detailViewModel
    }
}
