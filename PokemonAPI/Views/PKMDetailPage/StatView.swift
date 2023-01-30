//
//  StatView.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 29/01/23.
//

import SwiftUI

struct StatView: View {
    let stat: StatModel
    let color: Color
    var body: some View {
        HStack(spacing: 8) {
            Text(stat.title)
                .multilineTextAlignment(.leading)
                .font(.custom(FontManager.Poppins.bold, size: 10))
                .frame(width: 28.0)
            Divider()
            Text("\(stat.value)")
                .multilineTextAlignment(.leading)
                .font(.custom(FontManager.Poppins.regule, size: 10))
                .frame(width: 20.0)
            ProgressView(value: Float32(stat.value), total: 200)
                .tint(color)
                .background(color.opacity(0.1))
        }
        .foregroundColor(.black)
        .frame(height: 16)
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(stat: StatModel(title: "HP", value: 102), color: Color.green)
    }
}
