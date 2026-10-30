//
//  WelcomeText.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 13/01/2026.
//

import SwiftUI

struct LevelNode: View {
    let level: Int
    let title: String
    let isCompleted: Bool

    @State private var pulseScale: CGFloat = 1.0
    @State private var rotate = 0.0

    private let screen = UIScreen.main.bounds
    private var nodeSize: CGFloat  { screen.width * 0.1 }
    private var glowSize: CGFloat  { nodeSize * 1.18 }
    private var iconSize: CGFloat  { nodeSize * 0.36 }
    private var titleSize: CGFloat { nodeSize * 0.17 }

    var body: some View {
        VStack(spacing: nodeSize * 0.14) {

            ZStack {
                Circle()
                    .fill(glowColor)
                    .frame(width: glowSize, height: glowSize)
                    .blur(radius: glowSize * 0.21)
                    .opacity(0.45)
                    .scaleEffect(!isCompleted ? pulseScale : 1.0)

                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: nodeSize, height: nodeSize)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        .white.opacity(0.55),
                                        .clear,
                                        glowColor.opacity(0.4)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.5
                            )
                    )
                    .shadow(color: .black.opacity(0.4), radius: 10, y: 8)

                Group {
                    if isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: iconSize, weight: .black))
                            .foregroundStyle(Color(red: 0.1, green: 0.9, blue: 0.55))
                    } else {
                        Image(systemName: "sparkle")
                            .font(.system(size: iconSize + 2, weight: .bold))
                            .foregroundStyle(Color(red: 1.0, green: 0.85, blue: 0.3))
                    }
                }
            }
            .contentShape(Circle())

            Text(title)
                .font(.system(size: titleSize, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.top, -10)
        }
        .onAppear {
            if !isCompleted {
                withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                    pulseScale = 1.18
                }
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                    rotate = 360
                }
            }
        }
    }

    private var glowColor: Color {
        if isCompleted { return Color(red: 0.1, green: 0.9, blue: 0.55) }
        return Color(red: 1.0, green: 0.82, blue: 0.25)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        HStack(spacing: 40) {
            LevelNode(level: 1, title: "Budgeting", isCompleted: true)
            LevelNode(level: 2, title: "Compound\nInterest", isCompleted: false)
        }
    }
}
