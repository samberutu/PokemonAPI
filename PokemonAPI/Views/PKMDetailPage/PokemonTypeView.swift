//
//  PokemonTypeView.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 30/01/23.
//

import SwiftUI

struct PokemonTypeView: View {
    let title: String
    let bgColor: Color
    var body: some View {
        Text(title)
            .font(.custom(FontManager.Poppins.bold, size: 10))
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(bgColor)
            .cornerRadius(10)
    }
}

struct PokemonTypeView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeView(title: "Fire", bgColor: ColorManager.PKMFire)
    }
}
