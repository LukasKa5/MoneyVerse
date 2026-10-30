//
//  SceneLoader.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 26/02/2026.
//

import Foundation
import Combine
import SwiftUI
import RealityKit

@MainActor
class SceneLoader: ObservableObject {
    static let shared = SceneLoader()
    
    @Published var inflationScene: Entity?
    @Published var compoundScene: Entity?
    @Published var debtScene: Entity?
    
    var compoundGiant: Entity?
    var inflationNebula: Entity?
    var gravityOfDebt: Entity?
    
    @Published var isReady = false

    func loadAll() async {
        if isReady {
            return
        }

        async let inflation    = try? await Entity(named: "InflationNebulaSurface", in: .main)
        async let compound     = try? await Entity(named: "CompoundGiantSurface", in: .main)
        async let debt         = try? await Entity(named: "TheGravityOfDebtSurface", in: .main)
        async let menuCompound  = try? await Entity(named: "CompoundGiant", in: .main)
        async let menuInflation = try? await Entity(named: "InflationNebula", in: .main)
        async let menuDebt      = try? await Entity(named: "TheGravityOfDebt", in: .main)

        self.inflationScene  = await inflation
        self.compoundScene   = await compound
        self.debtScene       = await debt
        self.compoundGiant   = await menuCompound
        self.inflationNebula = await menuInflation
        self.gravityOfDebt   = await menuDebt
        
        withAnimation {
            self.isReady = true
        }
        print("Assets preloaded successfully.")
    }
}
