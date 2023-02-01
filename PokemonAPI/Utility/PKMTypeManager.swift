//
//  PKMTypeManager.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 30/01/23.
//

import SwiftUI

protocol GetPKMColor {
    var typeColor: Color { get }
}

enum PKMType: String, CaseIterable {
    case rock = "rock"
    case ghost = "ghost"
    case steel = "steel"
    case water = "water"
    case grass = "grass"
    case psychic = "psychic"
    case ice = "ice"
    case dark = "dark"
    case fairy = "fairy"
    case normal = "normal"
    case fighting = "fighting"
    case flying = "flying"
    case poison = "poison"
    case ground = "ground"
    case bug = "bug"
    case fire = "fire"
    case electric = "electric"
    case dragon = "dragon"
}

extension PKMType: GetPKMColor {
    var typeColor: Color {
        switch self {
        case .rock:
            return ColorManager.PKMRock
        case .ghost:
            return ColorManager.PKMGhost
        case .steel:
            return ColorManager.PKMSteel
        case .water:
            return ColorManager.PKMWater
        case .grass:
            return ColorManager.PKMGrass
        case .psychic:
            return ColorManager.PKMPsychic
        case .ice:
            return ColorManager.PKMIce
        case .dark:
            return ColorManager.PKMDark
        case .fairy:
            return ColorManager.PKMFairy
        case .normal:
            return ColorManager.PKMNormal
        case .fighting:
            return ColorManager.PKMFighting
        case .flying:
            return ColorManager.PKMFlying
        case .poison:
            return ColorManager.PKMPoison
        case .ground:
            return ColorManager.PKMGround
        case .bug:
            return ColorManager.PKMBug
        case .fire:
            return ColorManager.PKMFire
        case .electric:
            return ColorManager.PKMElectric
        case .dragon:
            return ColorManager.PKMDragon
        }
    }
}
