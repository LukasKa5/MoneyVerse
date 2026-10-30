//
//  WelcomeText.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 13/01/2026.
//

import SwiftUI

struct WelcomeText: View {
    let onSequenceFinished: () -> Void
    @StateObject private var audio = AudioManager.shared

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()

            VStack(spacing: 0) {

                Spacer()

                Image(systemName: "sparkles")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(.white)
                    .symbolEffect(.pulse)
                    .padding(.bottom, 24)

                Text("WELCOME TO")
                    .font(.system(size: 11, weight: .heavy, design: .monospaced))
                    .foregroundStyle(.white.opacity(0.6))
                    .kerning(3)
                    .padding(.bottom, 12)

                Text("MoneyVerse")
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 12)

                Text("Tap on any planet to start your journey. Choose any level you want to try! \n I do recommend to start with Levels marked as  \"Level 1\" on each planet. \n Also try to use Future Self mode in top right corner to plan your financial future!")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer()

                Button {
                    UserDefaults.standard.set(true, forKey: "hasSeenIntro")
                    onSequenceFinished()
                } label: {
                    Text("CONTINUE")
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .kerning(1)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(red: 1.0, green: 0.85, blue: 0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding(.horizontal, 32)
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 32)
            }
        }
        .onAppear {
            audio.playSong(named: "MoneyVerseBackground", loops: -1, volume: 0.008)
        }
    }
}

#Preview {
    WelcomeText(onSequenceFinished: {})
}
