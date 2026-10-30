//
//  RocketIntroView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 06/01/2026.
//

import SwiftUI
import RealityKit

struct RocketIntroView: View {
    let onSequenceFinished: () -> Void
    @StateObject var audio = AudioManager.shared
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            RealityView { content in
                
                let mesh = MeshResource.generateText("Welcome to MoneyVerse", extrusionDepth: 0.01, font: .systemFont(ofSize: 0.2))
                let textEntity = ModelEntity(mesh: mesh, materials: [UnlitMaterial(color: .white)])
                textEntity.position = [-1.3, -0.1, 0]
                content.add(textEntity)
                
                guard let rocket = try? await Entity(named: "Rocket") else { return }
                
                rocket.position = [1.5, 0.0, 2.0]
                rocket.orientation = simd_quatf(angle: 17, axis: [1, 0, 0])
                content.add(rocket)
                
                
                var firstTransform = rocket.transform
                firstTransform.translation = [-4.0, 0.0, 0.0]
                firstTransform.rotation = rocket.orientation
                rocket.move(to: firstTransform, relativeTo: nil, duration: 3.5, timingFunction: .easeInOut)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    var turnTransform = rocket.transform
                    let yTurn = simd_quatf(angle: -.pi, axis: [0, 1, 0])
                    turnTransform.rotation = yTurn * rocket.orientation
                    rocket.move(to: turnTransform, relativeTo: nil, duration: 0.1, timingFunction: .easeInOut)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    var farTransform = rocket.transform
                    farTransform.translation = [8.0, 0.0, -3.0]
                    farTransform.scale = [0.05, 0.05, 0.05]
                    rocket.move(to: farTransform, relativeTo: nil, duration: 2.0, timingFunction: .easeIn)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                    onSequenceFinished()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    audio.playSong(named: "RocketSound", loops: 1, volume: 0.05)
                }
            }
        }
    }
}

struct StarsBackgroundView: View {
    var body: some View {
        Canvas { context, size in
            for _ in 0...200 {
                let x = CGFloat.random(in: 0...size.width)
                let y = CGFloat.random(in: 0...size.height)
                let s = CGFloat.random(in: 0.5...2)
                context.fill(Path(ellipseIn: CGRect(x: x, y: y, width: s, height: s)), with: .color(.white.opacity(0.6)))
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RocketIntroView(onSequenceFinished: {})
}

