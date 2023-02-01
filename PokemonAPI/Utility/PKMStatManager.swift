//
//  PKMStatManager.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 01/02/23.
//

import Foundation

enum PKMStatsManager: String, CaseIterable {
    case hp = "hp"
    case attack = "attack"
    case defense = "defense"
    case satt = "special-attack"
    case sdef = "special-defense"
    case speed = "speed"
}

extension PKMStatsManager {
    var statType: String {
        switch self {
        case .hp:
            return "HP"
        case .attack:
            return "ATK"
        case .defense:
            return "DEF"
        case .satt:
            return "SATK"
        case .sdef:
            return "SDEF"
        case .speed:
            return "SPD"
        }
    }
}
