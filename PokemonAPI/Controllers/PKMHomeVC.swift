//
//  ViewController.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 27/01/23.
//

import UIKit

final class PKMHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Pokemon"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addNewView() {
        
    }
}
