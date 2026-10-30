//
//  MoneyVerseApp.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 23/12/2025.
//

import SwiftUI

@main
struct MoneyVerseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await SceneLoader.shared.loadAll()
                }
        }
    }
}
