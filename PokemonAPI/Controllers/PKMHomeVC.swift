//
//  ViewController.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 27/01/23.
//

import UIKit
import SkeletonView
import SwiftUI

final class PKMHomeVC: UIViewController {
    private var viewModel = PKMHomeViewModel()
    
    private var pokemonsCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonsCell.self, forCellWithReuseIdentifier: PokemonsCell.identifier)
        return collectionView
    }()
    
    var profiles: [Profile] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSkeletonView()
        viewModel.fetchPKMList {
            self.setupData()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Pokemon"
        navigationController?.navigationBar.prefersLargeTitles = true
        pokemonsCollectionView.dataSource = self
        pokemonsCollectionView.delegate = self
        view.addSubview(pokemonsCollectionView)
        pokemonsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // layout constraint
        NSLayoutConstraint.activate([
            pokemonsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pokemonsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pokemonsCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            pokemonsCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func setupData() {
        pokemonsCollectionView.reloadData()
        pokemonsCollectionView.stopSkeletonAnimation()
        view.hideSkeleton()
    }
    
    func setupSkeletonView() {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        pokemonsCollectionView.isSkeletonable = true
        pokemonsCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .secondaryLabel),
                                                            animation: animation,
                                                            transition: .crossDissolve(0.3))
    }
    
    private func populateProfiles() {
        profiles = [
            Profile(name: "Thor", location: "Boston", imageName: "astronomy", profession: "astronomy"),
            Profile(name: "Mike", location: "Albequerque", imageName: "basketball", profession: "basketball"),
            Profile(name: "Walter White", location: "New Mexico", imageName: "chemistry", profession: "chemistry"),
            Profile(name: "Sam Brothers", location: "California", imageName: "geography", profession: "geography"),
            Profile(name: "Chopin", location: "Norway", imageName: "geometry", profession: "geometry"),
            Profile(name: "Castles", location: "UK", imageName: "history", profession: "history"),
            Profile(name: "Dr. Johnson", location: "Australia", imageName: "microscope", profession: "microscope"),
            Profile(name: "Tom Hanks", location: "Bel Air", imageName: "theater", profession: "theater"),
            Profile(name: "Roger Federer", location: "Switzerland", imageName: "trophy", profession: "trophy"),
            Profile(name: "Elon Musk", location: "San Francisco", imageName: "graduate", profession: "graduate")
        ]
    }
}

extension PKMHomeVC: SkeletonCollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        PokemonsCell.identifier
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pokemonsCollectionView.dequeueReusableCell(withReuseIdentifier: PokemonsCell.identifier, for: indexPath) as! PokemonsCell
        let pokemon = viewModel.result[indexPath.row]
        let id = indexPath.row + 1
        cell.fetchData(id: String(id), pkmName: pokemon.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = LayoutConstant.width
        return CGSize(width: width, height: width + 8)
    }

}

extension PKMHomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openSwiftUIScreen(pkmId: String(indexPath.row + 1), pkmCount: viewModel.itemCount)
    }
    
    func openSwiftUIScreen(pkmId: String, pkmCount: Int) {
        let swiftUIViewController = UIHostingController(rootView: PKMDetailView(pkmId: pkmId, pkmCount: pkmCount))
        self.navigationController?.pushViewController(swiftUIViewController, animated: true)
    }
}

// MARK: - for another variable
enum LayoutConstant {
    static let spacing: CGFloat = 2
    static let width: CGFloat = (UIScreen.main.bounds.width-64)/3
}

struct Profile {
    let name: String
    let location: String
    let imageName: String
    let profession: String
}
