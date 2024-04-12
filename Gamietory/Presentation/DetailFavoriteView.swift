//
//  DetailFavoriteView.swift
//  Gamietory
//
//  Created by Ryo Martin on 09/04/24.
//

import SwiftUI
import Foundation

struct DetailFavoriteView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var bookmarkResult: FetchedResults<Bookmark>
    
    @ObservedObject var viewModel = GameViewModel()
    let gamee: Bookmark
    


    var body: some View {
        ScrollView {
            VStack {
                let id = gamee.id
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
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        if let dataResults = viewModel.gameDetailResponses {
                            let desc = dataResults.description?.removingHTMLTags() ?? ""
                            Text(desc)
                        }
                    }
                    Spacer()
                    Divider()
                }.padding()
            }.onAppear {
                let id = gamee.id
                viewModel.fetchDetail(id: id)
            }
        }
    }
    
    func bookmarkExists(gameID: Int) -> Bool {
        return bookmarkResult.first(where: { $0.id == Int64(gameID) }) != nil
    }
}

extension String {
    func removingHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

//#Preview {
//    DetailFavoriteView()
//}
