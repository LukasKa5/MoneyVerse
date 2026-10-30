//
//  ContentView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 23/12/2025.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    
    @AppStorage("HasSeenIntro") var hasSeenIntro = false
    
    var body: some View {
        Group {
            if hasSeenIntro {
                MenuView()
            } else {
                IntroSequenceViewManager()
            }
        }
    }
}

#Preview {
    ContentView()
}

