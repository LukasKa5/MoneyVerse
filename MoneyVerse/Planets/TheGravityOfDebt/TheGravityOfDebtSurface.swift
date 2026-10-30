//
//  TheGravityOfDebtSurface.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 25/02/2026.
//

import SwiftUI
import RealityKit

struct TheGravityOfDebtSurface: View {
    @StateObject var loader = SceneLoader.shared
    @StateObject var manager = LevelManager.shared
    @State private var activeQuizLevel: Int? = nil
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                StarBackgroundView()
                RealityView { content in
                    if let scene = loader.debtScene?.clone(recursive: true) {
                        scene.position = .init(x: 0, y: -0.1, z: 1.55)
                        scene.orientation = .init(angle: Float(Angle(degrees: 270).radians), axis: [0, 1, 0])
                        content.add(scene)
                    }
                }
                .ignoresSafeArea()
                .allowsHitTesting(false)
            }
            .overlay(
                ZStack {
                    Button { activeQuizLevel = 1 } label: {
                        LevelNode(level: 1, title: "Good vs Bad\nDebt", isCompleted: manager.isCompleted(1, surface: .debt))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .position(x: geo.size.width * 0.25, y: geo.size.height * 0.25)

                    Button { activeQuizLevel = 2 } label: {
                        LevelNode(level: 2, title: "Credit Scores", isCompleted: manager.isCompleted(2, surface: .debt))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .position(x: geo.size.width * 0.50, y: geo.size.height * 0.35)

                    Button { activeQuizLevel = 3 } label: {
                        LevelNode(level: 3, title: "Fight Housing\nCrisis", isCompleted: manager.isCompleted(3, surface: .debt))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .position(x: geo.size.width * 0.75, y: geo.size.height * 0.30)
                }
            )
        }
        .ignoresSafeArea()
        .sheet(item: $activeQuizLevel) { level in
            LevelStartSheet(level: level, surface: .debt)
        }
        
    }
}

#Preview {
    TheGravityOfDebtSurface()
}
