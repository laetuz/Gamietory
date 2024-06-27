//
//  FavoriteView.swift
//  Gamietory
//
//  Created by Ryo Martin on 08/04/24.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var games: FetchedResults<Bookmark>
    let gameViewModel = GameViewModel(useCase: Injection.init().provideGamesUseCase())

    var body: some View {
        NavigationView {
            List {
                ForEach(games) { item in
                    NavigationLink(destination: DetailFavoriteView(viewModel: gameViewModel, gamee: item)) {
                        VStack {
                            HStack {
                                Spacer()
                                AsyncImageComp(imageUrl: item.background_image ?? "", scale: 10, frameHeight: 100)
                                Spacer()
                            }.frame(height: 100)
                            Text(item.name ?? "").background(.ultraThinMaterial)
                            let rating = String(item.rating)
                            let release = String(item.released ?? "")
                            Text("Release date: \(release)")
                            Text("Rating: \(rating)")

                        }.padding()
                    }
                }
            }.navigationTitle("Favorite")
        }
    }
}

#Preview {
    FavoriteView()
}
