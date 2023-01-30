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

enum PKMType {
    case rock
    case ghost
    case steel
    case water
    case grass
    case psychic
    case ice
    case dark
    case fairy
    case normal
    case fighting
    case flying
    case poison
    case ground
    case bug
    case fire
    case electric
    case dragon
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
