//
//  ContentView.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import SwiftUI

struct ContentView: View {
    let gameViewModel = GameViewModel(useCase: Injection.init().provideGamesUseCase())

    var body: some View {
        TabView {
            GameList(viewModel: gameViewModel)
                .tabItem { Label("Game", systemImage: "gamecontroller") }
            AboutPage()
                .tabItem { Label("About", systemImage: "person") }
            FavoriteView()
                .tabItem { Label("Favorite", systemImage: "star") }
        }
    }
}

#Preview {
    ContentView()
}
