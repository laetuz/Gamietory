//
//  GameDetail.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import SwiftUI

struct GameDetail: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var bookmarkResult: FetchedResults<Bookmark>

    let game: Results
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImageComp(imageUrl: game.backgroundImage ?? "", scale: 5)//.blur(radius: 20)
                Text(game.name ?? "Loading").font(.title)
                VStack(alignment: .leading) {
                    let rating = String(game.rating ?? 0)
                    let release = String(game.released ?? "")
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Release date: \(release)")
                            Text("Rating: \(rating)")
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Button(action: {
                                if !bookmarkExists(gameID: game.id ?? 0) {
                                    let save = Bookmark(context: moc)
                                    save.id = Int64(game.id ?? 0)
                                    save.name = game.name
                                    save.released = game.released
                                    save.background_image = game.backgroundImage
                                    save.rating = game.rating ?? 0
                                    save.isFavorited = true
                                    
                                    try? moc.save()
                                } else {
                                    if let existingBookmark = bookmarkResult.first(where: { $0.id == Int64(game.id ?? 0) }) {
                                        moc.delete(existingBookmark)
                                        try? moc.save()
                                    } else {
                                        print("Bookmark not found")
                                    }
                                }
                            }) {
                                Image(systemName: bookmarkExists(gameID: game.id ?? 0) ? "star.fill" : "star")
                                    .foregroundColor(bookmarkExists(gameID: game.id ?? 0) ? .yellow : .gray)
                            }
                        }
                    }
                   
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
    
    func bookmarkExists(gameID: Int) -> Bool {
        return bookmarkResult.first(where: { $0.id == Int64(gameID) }) != nil
    }
}

//#Preview {
//    let screenshotsDummy = ShortScreenshots(id: 2, image: "")
//    var resultDummy = Results(id: 3, slug: "", name: "", released: "", tba: false, background_image: "", rating: 3, rating_top: 4, shortScreenshots: [screenshotsDummy])
//    GameDetail(game: resultDummy)
//}
