//
//  AboutView.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 29/01/23.
//

import SwiftUI

struct AboutView: View {
    let aboutTitle: [String] = ["Weight", "Height", "Moves"]
    let idx = 0
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Image(systemName: "scalemass")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding(.trailing, 8)
                    Text("39 kg")
                        .font(.custom(FontManager.Poppins.regule, size: 10))
                }
                .frame(height: 32)
                Text("Weight")
                    .font(.custom(FontManager.Poppins.regule, size: 8))
            }
            .padding(.trailing, 12)
            Divider()
            VStack {
                HStack {
                    Image(systemName: "ruler")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(.degrees(-90))
                        .frame(width: 16, height: 16)
                        .padding(.trailing, 8)
                    Text("0,7 m")
                        .font(.custom(FontManager.Poppins.regule, size: 10))
                }
                .frame(height: 32)
                Text("Height")
                    .font(.custom(FontManager.Poppins.regule, size: 8))
            }
            .padding(.horizontal, 12)
            Divider()
            VStack {
                VStack {
                    Text("Chlorophyll")
                        .font(.custom(FontManager.Poppins.regule, size: 10))
                        .lineLimit(1)
                    Text("Overgrow")
                        .font(.custom(FontManager.Poppins.regule, size: 10))
                        .lineLimit(1)
                }
                .frame(height: 32)
                Text("Moves")
                    .font(.custom(FontManager.Poppins.regule, size: 8))
            }
            .padding(.leading, 12)
        }
        .foregroundColor(.black)
        .frame(height: 48)
    }
    
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

struct AboutItemView: View {
    let title: String
    let image: UIImage?
    var body: some View {
        VStack {
            HStack {
                
            }
            Text(title)
        }
    }
}
