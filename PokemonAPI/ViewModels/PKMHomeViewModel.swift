//
//  PKMHomeViewModel.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 30/01/23.
//

import Foundation
import UIKit
import Combine

class PKMHomeViewModel {
    private let networkRepository: DataSourceRepositoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    var result: [PKMListModel] = []
    var previouwsLink: String = ""
    var nextLink: String = ""
    var isPaginating = false
    var offsetItem = 30
    var limitItem = 30
    var itemCount = 0
    var isNeedToReloadData = true
    
    init(networkRepository: DataSourceRepositoryProtocol) {
        self.networkRepository = networkRepository
    }
    
    func fetchPKMList(viewController: UIViewController, successAction: @escaping () -> Void, failureAction: (() -> Void)? = nil) {
        isPaginating = true
        let endpoint = FetchPokemonEndpoint(pokemonEndpoint: .getPKMList(offset: offsetItem, limit: limitItem))
        networkRepository.request(to: endpoint, decodeTo: PKMListResponse<PKMListModel>.self)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.isPaginating = false
                    self.offsetItem += 30
                    self.isNeedToReloadData = false
                case .failure(let error):
                    self.offsetItem -= 30
                    AlertHelper.displayError(message: error.errorMessage, viewController: viewController, action: failureAction)
                }
            } receiveValue: { response in
                self.itemCount = response.results.count
                self.result.append(contentsOf: response.results)
                DispatchQueue.main.async {
                    successAction()
                }
            }
            .store(in: &cancellables)        
    }
    
    func createProgressView(view: UIView) -> UIView {
        let footerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: 100))
        let progressView = UIActivityIndicatorView()
        progressView.center = footerView.center
        footerView.addSubview(progressView)
        progressView.startAnimating()
        return footerView
    }
    
    func provideCellRepository() -> PKMCellViewModel {
        return Injection.init().provideCellRepository()
    }
    
    func providePKMDetailViewModel() -> PKMDetailViewModel {
        return Injection.init().providePKMDetailViewModel()
    }
}
