//
//  PokemonsCell.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 27/01/23.
//

import UIKit
import SkeletonView

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class PokemonsCell: UICollectionViewCell, ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    private enum Constants {
        // MARK: contentView layout constants
        static let contentViewCornerRadius: CGFloat = 8.0
        
        // MARK: profileImageView layout constants
        static let imageWidth: CGFloat = LayoutConstant.width/2
        
        // MARK: Generic layout constants
        static let verticalSpacing: CGFloat = 4.0
        static let horizontalPadding: CGFloat = LayoutConstant.spacing
        static let profileDescriptionVerticalPadding: CGFloat = 8.0
    }
    
    private let pokemonImg: UIImageView = {
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
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(pokemonImg)
        contentView.addSubview(pokemonName)
        contentView.addSubview(pokemonNumber)
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
    
    func setup(_ profile: Profile) {
        pokemonImg.image = UIImage(named: "Example")
        pokemonImg.tintColor = .white
        pokemonName.text = profile.name
        pokemonName.backgroundColor = .blue
        pokemonNumber.text = "999"
    }
    
}
