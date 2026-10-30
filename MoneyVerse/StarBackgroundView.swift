//
//  StarsBackgroundView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 19/02/2026.
//

import SwiftUI

struct StarBackgroundView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ForEach(0..<350, id: \.self) { _ in
                Circle()
                    .fill(.white)
                    .frame(width: CGFloat.random(in: 1...3))
                    .position(
                        x: CGFloat.random(in: 0...2000),
                        y: CGFloat.random(in: 0...2000)
                    )
                    .opacity(Double.random(in: 0.1...1.0))
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    StarBackgroundView()
}
