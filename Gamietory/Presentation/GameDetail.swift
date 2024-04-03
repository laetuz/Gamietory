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
                VStack(alignment: .leading) {
                    let rating = String(game.rating ?? 0)
                    let release = String(game.released ?? "")
                    Text("Release date: \(release)")
                    Text("Rating: \(rating)")
                    Spacer()
                    Divider()
                    Text("More screenshots:")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(game.shortScreenshots) { item in
                                AsyncImageComp(imageUrl: item.image ?? "", scale: 10)
                            }
                        }
                    }
                }.padding()
            }
        }
        
    }
}

//#Preview {
//    GameDetail()
//}
