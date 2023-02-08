//
//  PKMDetailView.swift
//  PokemonAPI
//
//  Created by Samlo Berutu on 29/01/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PKMDetailView: View {
    @Environment(\.presentationMode) var presentation
    let pkmId: String
    let pkmCount: Int
    @StateObject var viewModel: PKMDetailViewModel
    let devicewidth = UIScreen.main.bounds.size.width
    let deviceHeight = UIScreen.main.bounds.size.height
    var body: some View {
        ZStack {
            Color(viewModel.getTypeColor())
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
            ScrollView {
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
                        
                        Text(viewModel.pokemonDetail.name)
                            .font(.custom(FontManager.Poppins.bold, size: 24))
                            .bold()
                            .lineLimit(1)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                        Spacer()
                        Text("#\(String(format: "%04d", viewModel.pokemonDetail.id))")
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
                                if viewModel.pokemonDetail.id <= 1 {
                                    Spacer()
                                } else {
                                    Button {
                                        viewModel.fetchPKMDetail(pkmId: String(viewModel.pokemonDetail.id - 1))
                                    } label: {
                                        Image(systemName: "chevron.left")
                                            .foregroundColor(ColorManager.PKMWhite)
                                    }
                                }
                                Spacer()
                                if viewModel.pokemonDetail.id >= pkmCount {
                                    Spacer()
                                } else {
                                    Button {
                                        viewModel.fetchPKMDetail(pkmId: String(viewModel.pokemonDetail.id + 1))
                                    } label: {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(ColorManager.PKMWhite)
                                    }
                                }
                            }
                            .frame(height: 16)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 24)
                            ZStack {
                                ColorManager.PKMBackground
                                    .ignoresSafeArea(.all)
                                    .cornerRadius(8.0)
                            }
                        }
                        .padding(.top, deviceHeight/7)
                        .padding(.bottom, 4)
                        VStack {
                            WebImage(url: URL(string: viewModel.pokemonDetail.sprites.other.officialArtwork.frontDefault))
                                .resizable()
                                .indicator(.activity)
                                .scaledToFit()
                                .frame(width: devicewidth/2, height: devicewidth/2)
                            HStack {
                                ForEach(viewModel.pokemonDetail.types.indices, id: \.self) { idx in
                                    let species = viewModel.pokemonDetail.types[idx].type
                                    let bgColor = viewModel.getTypesColor()[idx]
                                    PokemonTypeView(title: species.name, bgColor: bgColor)
                                }
                                .scrollDisabled(true)
                            }
                            Text("About")
                                .foregroundColor(Color(viewModel.getTypeColor()))
                                .font(.custom(FontManager.Poppins.bold, size: 14))
                                .padding(.top, 16)
                            AboutView(weight: viewModel.pokemonDetail.weight,
                                      height: viewModel.pokemonDetail.height,
                                      moves: viewModel.getMoves())
                            .padding(.top)
                            Text(viewModel.pkmDescription
                                .replacingOccurrences(of: "\\f", with: " "))
                                .font(.custom(FontManager.Poppins.regule, size: 10))
                                .foregroundColor(.black)
                                .lineLimit(3)
                                .padding(.top, 16)
                            Text("Base Stats")
                                .foregroundColor(Color(viewModel.getTypeColor()))
                                .font(.custom(FontManager.Poppins.bold, size: 14))
                                .padding(.top, 16)
                            VStack {
                                ForEach(viewModel.pokemonDetail.stats.indices, id: \.self) { idx in
                                    StatView(title: viewModel.getStatTitle()[idx],
                                             value: String(viewModel.pokemonDetail.stats[idx].baseStat),
                                             color: Color(viewModel.getTypeColor()))
                                }
                            }
                            .padding(.top, 16)
                            .padding(.bottom, 32)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 32)
                    }
                    .padding(.horizontal, 8)
                }
            }
            if viewModel.isLoadData {
                Color.black
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ProgressView()
                        .scaleEffect(2)
                    Text(viewModel.errorMessage)
                        .font(.custom(FontManager.Poppins.bold, size: 14))
                        .padding()
                }
                
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchPKMDetail(pkmId: pkmId)
        }
    }
    
}

struct PKMDetailView_Previews: PreviewProvider {
    let viewModel = Injection.init().providePKMDetailViewModel()
    static var previews: some View {
        PKMDetailView(pkmId: "1", pkmCount: 12, viewModel: Injection.init().providePKMDetailViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
        PKMDetailView(pkmId: "1", pkmCount: 12, viewModel: Injection.init().providePKMDetailViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewDisplayName("iPhone 8")
        PKMDetailView(pkmId: "1", pkmCount: 12, viewModel: Injection.init().providePKMDetailViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
    }
}
