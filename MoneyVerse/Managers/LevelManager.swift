//
//  LevelManager.swift
//  MoneyVerse
//

import SwiftUI
import Combine

enum SurfaceID: String {
    case inflation = "inflation"
    case compound  = "compound"
    case debt      = "debt"
}

class LevelManager: ObservableObject {
    static let shared = LevelManager()
    private init() {}

    func isCompleted(_ level: Int, surface: SurfaceID) -> Bool {
        UserDefaults.standard.bool(forKey: "\(surface.rawValue)_\(level)")
    }

    func completeLevel(_ level: Int, surface: SurfaceID) {
        UserDefaults.standard.set(true, forKey: "\(surface.rawValue)_\(level)")
        objectWillChange.send()
    }
}
