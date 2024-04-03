//
//  AboutPage.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import SwiftUI

struct AboutPage: View {
    var body: some View {
        VStack {
            AsyncImageComp(imageUrl: "https://media.licdn.com/dms/image/D5603AQGE0-jFfLKZ4Q/profile-displayphoto-shrink_800_800/0/1670758970954?e=1717632000&v=beta&t=Q-ihbW9fB4lotBqFTVYzY3Vg18c4JXKAmkk5DsCdDWE")
            Text("Ryo Martin Sopian").font(.title)
            Text("Android/iOS Native Developer")
            Spacer()
        }
    }
}

#Preview {
    AboutPage()
}
