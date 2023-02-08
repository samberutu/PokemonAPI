//
//  PokemonsCell.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 27/01/23.
//

import UIKit
import SkeletonView
import SDWebImage

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class PokemonsCell: UICollectionViewCell, ReusableView {
    private var viewModel = Injection.init().provideCellRepository()
    static var identifier: String {
        return String(describing: self)
    }
    
    let pokemonImg: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let pokemonName: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .center
        lbl.font = UIFont.preferredFont(forTextStyle: .caption1)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private let pokemonNumber: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = .right
        lbl.font = UIFont.preferredFont(forTextStyle: .caption1)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
        isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8.0
        contentView.backgroundColor = UIColor(ColorManager.PKMBackground)
        contentView.addSubview(pokemonImg)
        contentView.addSubview(pokemonName)
        contentView.addSubview(pokemonNumber)
        setupViewBeforeFetchData()
    }
    
    func setupLayout() {
        pokemonImg.translatesAutoresizingMaskIntoConstraints = false
        pokemonName.translatesAutoresizingMaskIntoConstraints = false
        pokemonNumber.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pokemonName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pokemonName.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            pokemonImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pokemonImg.bottomAnchor.constraint(equalTo: pokemonName.topAnchor),
            pokemonImg.topAnchor.constraint(equalTo: pokemonNumber.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pokemonNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            pokemonNumber.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonNumber.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupViewAfterGetData() {
        pokemonImg.sd_setImage(with: URL(string: viewModel.pokemonDetail.sprites.other.officialArtwork.frontDefault),
                               placeholderImage: viewModel.addProgressImage())
        contentView.layer.borderColor = viewModel.getTypeColor().cgColor
        pokemonImg.tintColor = .white
        pokemonName.text = viewModel.pokemonDetail.name
        pokemonName.backgroundColor = viewModel.getTypeColor()
        pokemonNumber.text = "#\(String(format: "%04d", viewModel.pokemonDetail.id))"
        pokemonNumber.textColor = UIColor(cgColor: viewModel.getTypeColor().cgColor)
    }
    
    func setupViewBeforeFetchData() {
        pokemonImg.image = UIImage(named: "Example")
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = ColorManager.PKMNormal.cgColor
        pokemonImg.tintColor = UIColor(ColorManager.PKMWhite)
        pokemonName.text = "NN"
        pokemonName.backgroundColor = UIColor(ColorManager.PKMNormal)
        pokemonNumber.text = "#0000"
        pokemonNumber.textColor = UIColor(cgColor: viewModel.getTypeColor().cgColor)
    }
    
    func fetchData(id: String, pkmName: String) {
        viewModel.fetchPKMDetail(id: id) {
            self.setupViewAfterGetData()
        }
    }
    
}
