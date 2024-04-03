//
//  GameDetail.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import SwiftUI

struct GameDetail: View {
    let game: Results
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImageComp(imageUrl: game.background_image ?? "", scale: 5)//.blur(radius: 20)
                Text(game.name ?? "Loading").font(.title)
                HStack {
                    VStack(alignment: .leading) {
                        var rating = String(game.rating ?? 0)
                        var release = String(game.released ?? "")
                        Text("Release date: \(release)")
                        Text("Rating: \(rating)")
                    }
                    Spacer()
                }.padding()
                Spacer()
            }
        }
        
    }
}

//#Preview {
//    GameDetail()
//}
