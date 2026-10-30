//
//  MenuView.swift
//  MoneyVerse
//

import SwiftUI
import RealityKit

struct MenuView: View {
    
    @StateObject var audio = AudioManager.shared
    @StateObject var loader = SceneLoader.shared
    
    @State private var selectedPlanet: String? = nil
    @State private var showFutureSelf = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                StarBackgroundView()
                
                if loader.isReady {
                    RealityView { content in
                        
                        // COMPOUND GIANT
                        if let modelCompoundGiant = loader.compoundGiant?.clone(recursive: true) {
                            modelCompoundGiant.name = "CompoundGiant"
                            let container = Entity()
                            container.position = [0, -0.1, 1]
                            container.name = "CompoundGiant"
                            content.add(container)
                            modelCompoundGiant.position = [0, 0, 0]
                            container.addChild(modelCompoundGiant)
                            let label = createTextEntity(text: "Compound Giant")
                            label.position = [-0.18, -0.3, -0.1]
                            container.addChild(label)
                            _ = content.subscribe(to: SceneEvents.Update.self) { _ in
                                modelCompoundGiant.orientation *= simd_quatf(angle: 0.003, axis: [0, 1, 0])
                            }
                        }
                        
                        // INFLATION NEBULA
                        if let modelInflationNebula = loader.inflationNebula?.clone(recursive: true) {
                            modelInflationNebula.name = "InflationNebula"
                            let container = Entity()
                            container.position = [0.8, 0, 0.8]
                            container.name = "InflationNebula"
                            content.add(container)
                            modelInflationNebula.position = [0, 0, 0]
                            container.addChild(modelInflationNebula)
                            let label = createTextEntity(text: "Inflation Nebula")
                            label.position = [-0.09, -0.17, -0.10]
                            container.addChild(label)
                            _ = content.subscribe(to: SceneEvents.Update.self) { _ in
                                modelInflationNebula.orientation *= simd_quatf(angle: 0.003, axis: [0, 1, 0])
                            }
                        }
                        
                        // THE GRAVITY OF DEBT
                        if let modelTheGravityOfDebt = loader.gravityOfDebt?.clone(recursive: true) {
                            modelTheGravityOfDebt.name = "TheGravityOfDebt"
                            let container = Entity()
                            container.position = [-0.5, 0.1, 1.1]
                            container.name = "TheGravityOfDebt"
                            content.add(container)
                            modelTheGravityOfDebt.position = [0, 0, 0]
                            container.addChild(modelTheGravityOfDebt)
                            let label = createTextEntity(text: "The Gravity of Debt")
                            label.position = [-0.38, -0.14, -0.3]
                            container.addChild(label)
                            _ = content.subscribe(to: SceneEvents.Update.self) { _ in
                                modelTheGravityOfDebt.orientation *= simd_quatf(angle: 0.003, axis: [0, 1, 0])
                            }
                        }
                    }
                    .gesture(
                        SpatialTapGesture()
                            .targetedToAnyEntity()
                            .onEnded { value in
                                selectedPlanet = value.entity.name
                            }
                    )
                    .onAppear {
                        audio.playSong(named: "MoneyVerseBackground", loops: -1, volume: 0.008)
                    }
                } else {
                    ProgressView()
                        .tint(.white)
                }

                VStack {
                    HStack {
                        Spacer()
                        Button { showFutureSelf = true } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundStyle(Color(red: 1.0, green: 0.85, blue: 0.3))
                                VStack(alignment: .leading, spacing: 1) {
                                    Text("Future Self")
                                        .font(.system(size: 13, weight: .black, design: .rounded))
                                        .foregroundStyle(.white)
                                    Text("Click to see your \n financial future")
                                        .font(.system(size: 10, weight: .medium, design: .rounded))
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(.ultraThinMaterial)
                            .environment(\.colorScheme, .dark)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.3), radius: 8, y: 4)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 20)
                        .padding(.top, 20)
                    }
                    Spacer()
                }
            }
            .navigationDestination(item: $selectedPlanet) { planetName in
                switch planetName {
                case "InflationNebula":  InflationNebulaSurface()
                case "CompoundGiant":    CompoundGiantSurface()
                case "TheGravityOfDebt": TheGravityOfDebtSurface()
                default:                 Text("Unknown Entity")
                }
            }
            .navigationDestination(isPresented: $showFutureSelf) {
                FutureSelfView(onComplete: { showFutureSelf = false })
            }
        }
    }
    
    func createTextEntity(text: String) -> Entity {
        let mesh = MeshResource.generateText(text, extrusionDepth: 0.0, font: .systemFont(ofSize: 0.04))
        let material = UnlitMaterial(color: .white)
        let entity = ModelEntity(mesh: mesh, materials: [material])
        entity.position.x = -(entity.visualBounds(relativeTo: nil).extents.x / 2)
        return entity
    }
}

#Preview {
    MenuView()
}
