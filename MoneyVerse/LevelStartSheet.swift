//
//  LevelStartSheet.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 23/02/2026.
//

import SwiftUI

extension SurfaceID {
    var levelTitles: [String] {
        switch self {
        case .inflation: return ["What is Inflation?", "Stocks, Bonds & ETFs", "Sustainable Investing"]
        case .compound:  return ["What is Compound Interest?", "Let Time Do Its Work", "Tackle Financial Stress"]
        case .debt:      return ["Good vs Bad Debt", "Credit Scores", "Fight Hausing Crisis"]
        }
    }
    
    var levelDescriptions: [String] {
        switch self {
        case .inflation: return ["Learn what inflation means for your wallet.", "Discover how to invest in stocks, ETFs or bonds.", "We have only one planet. Learn how to invest into companies that care about our future."]
        case .compound: return ["Learn how money grows exponentially over time.", "Discover why starting early makes a difference.", "Financial stress does not help your well-being. Learn how to cope with it."]
        case .debt: return ["Not all debt is bad — learn the difference.", "Get to know how credit works for and against you.", "Get to know one of the biggest crises in the past years."]
        }
    }
}

struct LevelStartSheet: View {
    let level: Int
    let surface: SurfaceID
    
    @StateObject var manager = LevelManager.shared
    @Environment(\.dismiss) var dismiss
    @State private var showLevel = false

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            
            VStack(spacing: 0) {
                Capsule()
                    .fill(.white)
                    .frame(width: 40, height: 4)
                    .padding(.top, 12)
                    .padding(.bottom, 28)
                
                Text("LEVEL \(level)")
                    .font(.system(size: 11, weight: .heavy, design: .monospaced))
                    .foregroundStyle(.white.opacity(0.6))
                    .kerning(3)
                    .padding(.bottom, 12)
                
                Text(surface.levelTitles[safe: level - 1] ?? "")
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 12)
                
                Text(surface.levelDescriptions[safe: level - 1] ?? "")
                    .font(.system(size: 15, weight: .medium, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                Button {
                    showLevel = true
                } label: {
                    Text(manager.isCompleted(level, surface: surface) ? "PLAY AGAIN" : "START LEVEL")
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
        .presentationDetents([.large])
        .presentationCornerRadius(28)
        .fullScreenCover(isPresented: $showLevel) {
            destinationView()
        }
    }
    
    @ViewBuilder
    private func destinationView() -> some View {
        switch surface {
        case .inflation:
            switch level {
            case 1: InflationLevel1View()
            case 2: InflationLevel2View()
            case 3: InflationLevel3View()
            default: EmptyView()
            }
        case .compound:
            switch level {
            case 1: CompoundLevel1View()
            case 2: CompoundLevel2View()
            case 3: CompoundLevel3View()
            default: EmptyView()
            }
        case .debt:
            switch level {
            case 1: DebtLevel1View()
            case 2: DebtLevel2View()
            case 3: DebtLevel3View()
            default: EmptyView()
            }
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Int: @retroactive Identifiable {
    public var id: Int { self }
}

#Preview {
    LevelStartSheet(level: 1, surface: .compound)
}
