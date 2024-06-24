//
//  AboutPage.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import SwiftUI

struct AboutPage: View {
    var body: some View {
        NavigationView {
            VStack {
                AsyncImageComp(imageUrl: Constants.profileImageUrl)
                Text("Ryo Martin Sopian").font(.title)
                Text("Android/iOS Native Developer")
                HStack {
                    Image(systemName: "mappin")
                    Text("Indonesia")
                }
                
                Spacer()
            }.navigationTitle("About me")
        }
        
    }
}

#Preview {
    AboutPage()
}
