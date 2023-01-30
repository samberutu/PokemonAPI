//
//  PKMDetailView.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 29/01/23.
//

import SwiftUI

struct PKMDetailView: View {
    @Environment(\.presentationMode) var presentation
    let name: String
    let devicewidth = UIScreen.main.bounds.size.width
    let deviceHeight = UIScreen.main.bounds.size.height
    let statsTitle = ["HP", "ATK", "DEF", "SATK", "SDEF", "SPD"]
    let stats: [StatModel] = [
        StatModel(title: "HP", value: 109),
        StatModel(title: "ATK", value: 179),
        StatModel(title: "DEF", value: 35),
        StatModel(title: "SATK", value: 105),
        StatModel(title: "SDEF", value: 45),
        StatModel(title: "SPD", value: 120)
    ]
    var body: some View {
        ZStack {
            Color(uiColor: .systemGreen)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Image(uiImage: UIImage(named: "Pokeball") ?? UIImage())
                        .resizable()
                        .frame(width: (devicewidth/5)*3, height: (devicewidth/5)*3)
                        .padding(.top, -16)
                }
                .padding(.trailing, 8)
                Spacer()
            }
            VStack {
                HStack {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 24)
                    }

                    Text("Bulbasaur")
                        .font(.custom(FontManager.Poppins.bold, size: 24))
                        .bold()
                        .lineLimit(1)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                    Spacer()
                    Text("#001")
                        .font(.custom(FontManager.Poppins.bold, size: 12))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading, 16)
                }
                .frame(height: 32)
                .padding(.horizontal, 24)
                ZStack {
                    VStack {
                        HStack {
                            Button {
                                print("")
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(ColorManager.PKMWhite)
                            }
                            Spacer()
                            Button {
                                print("")
                            } label: {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(ColorManager.PKMWhite)
                            }
                        }
                        .frame(height: 16)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        ZStack {
                            Color.white
                                .ignoresSafeArea(.keyboard)
                                .cornerRadius(8.0)
                        }
                    }
                    .padding(.top, deviceHeight/8)
                    VStack {
                        Image(uiImage: UIImage(named: "Example") ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: devicewidth/2, height: devicewidth/2)
                        PokemonTypeView(title: "Grass", bgColor: ColorManager.PKMGrass)
                        Text("About")
                            .foregroundColor(.green)
                            .font(.custom(FontManager.Poppins.bold, size: 14))
                            .padding(.top, 16)
                        AboutView()
                        .padding(.top)
                        Text("Pokémon (an abbreviation for Pocket Monsters[b] in Japan) is a Japanese media franchise managed by The Pokémon Company, founded by Nintendo, Game Freak, and Creatures.")
                            .font(.custom(FontManager.Poppins.regule, size: 10))
                            .foregroundColor(.black)
                            .lineLimit(3)
                            .padding(.top, 16)
                        Text("Base Stats")
                            .foregroundColor(.green)
                            .font(.custom(FontManager.Poppins.bold, size: 14))
                            .padding(.top, 16)
                        VStack {
                            ForEach(stats, id: \.id) { stat in
                                StatView(stat: stat, color: .green)
                            }
                        }
                        .padding(.top, 16)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 48)
                }
//                .padding(.top, 32)
                .padding(.horizontal, 8)
            }
        }
        .navigationBarHidden(true)
    }
    
}

struct PKMDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PKMDetailView(name: "Samlo")
    }
}
