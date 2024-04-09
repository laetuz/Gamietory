//
//  DetailFavoriteView.swift
//  Gamietory
//
//  Created by Ryo Martin on 09/04/24.
//

import SwiftUI

struct DetailFavoriteView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var bookmarkResult: FetchedResults<Bookmark>

    let gamee: Bookmark

    var body: some View {
        VStack {
            AsyncImageComp(imageUrl: gamee.background_image ?? "", scale: 5)//.blur(radius: 20)
            Text(gamee.name ?? "Loading").font(.title)
            VStack(alignment: .leading) {
                let rating = String(gamee.rating)
                let release = String(gamee.released ?? "")
                HStack {
                    VStack(alignment: .leading) {
                        Text("Release date: \(release)")
                        Text("Rating: \(rating)")
                    }
                    Spacer()
                    Button(action: {
                        if !bookmarkExists(gameID: Int(gamee.id)) {
                            let save = Bookmark(context: moc)
                            save.id = Int64(gamee.id)
                            save.name = gamee.name
                            save.released = gamee.released
                            save.background_image = gamee.background_image
                            save.rating = gamee.rating
                            save.isFavorited = true
                            
                            try? moc.save()
                        } else {
                            if let existingBookmark = bookmarkResult.first(where: { $0.id == Int64(gamee.id) }) {
                                moc.delete(existingBookmark)
                                try? moc.save()
                            } else {
                                print("Bookmark not found")
                            }
                        }
                    }) {
                        Image(systemName: bookmarkExists(gameID: Int(gamee.id)) ? "star.fill" : "star")
                            .foregroundColor(bookmarkExists(gameID: Int(gamee.id)) ? .yellow : .gray)
                    }
                }
               
                Spacer()
                Divider()
            }.padding()
        }
    }
    
    func bookmarkExists(gameID: Int) -> Bool {
        return bookmarkResult.first(where: { $0.id == Int64(gameID) }) != nil
    }
}

//#Preview {
//    DetailFavoriteView()
//}
