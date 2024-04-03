//
//  GameList.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import SwiftUI

struct GameList: View {
    @ObservedObject var viewModel = GameViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    if let dataResults = viewModel.gameResponses?.results {
                        List {
                            ForEach(dataResults) { item in
                                NavigationLink(destination: GameDetail(game: item)) {
                                    VStack {
                                        HStack{
                                            Spacer()
                                            AsyncImageComp(imageUrl: item.background_image ?? "", scale: 10, frameHeight: 100)
                                            Spacer()
                                        }.frame(height: 100)
                                        Text(item.name ?? "").background(.ultraThinMaterial)
                                        let rating = String(item.rating ?? 0)
                                        let release = String(item.released ?? "")
                                        Text("Release date: \(release)")
                                        Text("Rating: \(rating)")

                                    }.padding()
                                }
                            }
                        }
                    }
                }
            }.navigationTitle("Games List")
        }.onAppear(){
            viewModel.fetchGames()
        }
    }
}

#Preview {
    GameList()
}
