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
    private let networkRepository: NetworkServicing
    private var cancellables: Set<AnyCancellable> = []
    var result: [PKMListModel] = []
    var previouwsLink: String = ""
    var nextLink: String = ""
    var isPaginating = false
    var offsetItem = 0
    var limitItem = 20
    var itemCount = 0
    
    init(networkRepository: NetworkServicing = DataSourceRepository()) {
        self.networkRepository = networkRepository
    }
    
    func fetchPKMList(action: @escaping () -> Void) {
        isPaginating = true
        let endpoint = FetchPokemonEndpoint(pokemonEndpoint: .getPKMList(offset: offsetItem, limit: limitItem))
        networkRepository.request(to: endpoint, decodeTo: PKMListResponse<PKMListModel>.self)
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
                self.itemCount = response.count
                self.result += response.results
                self.offsetItem += response.results.count
                self.isPaginating = false
                action()
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
}
