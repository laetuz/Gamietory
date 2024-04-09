//
//  GamietoryApp.swift
//  Gamietory
//
//  Created by Ryo Martin on 03/04/24.
//

import SwiftUI

@main
struct GamietoryApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
