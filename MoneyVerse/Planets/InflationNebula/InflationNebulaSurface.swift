//
//  InflationNebulaSurface.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 17/02/2026.
//

import SwiftUI
import RealityKit

struct InflationNebulaSurface: View {
    @StateObject var loader  = SceneLoader.shared
    @StateObject var manager = LevelManager.shared
    @State private var activeQuizLevel: Int? = nil

    var body: some View {
        GeometryReader { geo in
            ZStack {
                StarBackgroundView()

                RealityView { content in
                    if let scene = loader.inflationScene?.clone(recursive: true) {
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
                        LevelNode(level: 1, title: "What is\nInflation?", isCompleted: manager.isCompleted(1, surface: .inflation))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .position(x: geo.size.width * 0.25, y: geo.size.height * 0.25)

                    Button { activeQuizLevel = 2 } label: {
                        LevelNode(level: 2, title: "Stocks, Bonds &\nETFs", isCompleted: manager.isCompleted(2, surface: .inflation))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .position(x: geo.size.width * 0.50, y: geo.size.height * 0.35)

                    Button { activeQuizLevel = 3 } label: {
                        LevelNode(level: 3, title: "Sustainable\n Investing", isCompleted: manager.isCompleted(3, surface: .inflation))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .position(x: geo.size.width * 0.75, y: geo.size.height * 0.30)
                }
            )
        }
        .ignoresSafeArea()
        .sheet(item: $activeQuizLevel) { level in
            LevelStartSheet(level: level, surface: .inflation)
        }
    }
}

#Preview {
    InflationNebulaSurface()
}
