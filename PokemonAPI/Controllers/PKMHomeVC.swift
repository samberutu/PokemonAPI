//
//  ViewController.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 27/01/23.
//

import UIKit
import SkeletonView
import SwiftUI

class PKMHomeVC: UIViewController {
    private var viewModel: PKMHomeViewModel
    
    init(viewModel: PKMHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var pokemonsCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        viewLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = UIColor(ColorManager.PKMBackground)
        collectionView.register(PokemonsCell.self, forCellWithReuseIdentifier: PokemonsCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSkeletonView()
        viewModel.fetchPKMList(viewController: self) {
            self.setupData()
        } failureAction: {
            self.viewModel.fetchPKMList(viewController: self) {
                self.setupData()
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupView() {
        title = "Pokemon"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(ColorManager.PKMDarkGray)]
        pokemonsCollectionView.dataSource = self
        pokemonsCollectionView.delegate = self
        pokemonsCollectionView.prefetchDataSource = self
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
    
}

// MARK: - Paginating

extension PKMHomeVC: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= viewModel.result.count - 3 && !viewModel.isPaginating {
                viewModel.fetchPKMList(viewController: self) {
                    self.setupData()
                } failureAction: {
                    self.viewModel.fetchPKMList(viewController: self) {
                        self.setupData()
                    }
                }

                break
            }
        }
    }

}

// MARK: - SekeltonView Data Spurce
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
// MARK: - Segue
extension PKMHomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.openSwiftUIScreen(pkmId: String(indexPath.row + 1), pkmCount: viewModel.itemCount)
    }
    
    func openSwiftUIScreen(pkmId: String, pkmCount: Int) {
        let swiftUIViewController = UIHostingController(rootView: PKMDetailView(pkmId: pkmId,
                                                                                pkmCount: pkmCount,
                                                                                viewModel: self.viewModel.providePKMDetailViewModel()))
        self.navigationController?.pushViewController(swiftUIViewController, animated: true)
    }
}

// MARK: - for another variable
enum LayoutConstant {
    static let spacing: CGFloat = 2
    static let width: CGFloat = (UIScreen.main.bounds.width-64)/3
}
