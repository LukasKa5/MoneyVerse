//
//  IntroSequenceView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 24/12/2025.
//

import SwiftUI

struct IntroSequenceViewManager: View {
    @AppStorage("HasSeenIntro") private var hasSeenIntro: Bool = false
    @State private var currentView = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            Group {
                if currentView == 0 {
                    RocketIntroView(onSequenceFinished: {
                        withAnimation(.easeInOut(duration: 4)) {
                            currentView = 1
                        }
                    })
                } else if currentView == 1 {
                    WelcomeText(onSequenceFinished: {
                        withAnimation(.smooth(duration: 4)) {
                            currentView = 2
                            hasSeenIntro = true 
                        }
                    })
                } else {
                    MenuView()
                }
            }
        }
    }
}

#Preview {
    IntroSequenceViewManager()
}
