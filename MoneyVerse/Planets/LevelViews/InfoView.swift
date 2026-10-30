//
//  InfoView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 20/02/2026.
//

import SwiftUI

struct InfoView: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: icon)
                .font(.system(size: 64))
                .foregroundStyle(Color(red: 1.0, green: 0.85, blue: 0.3))

            Text(title)
                .font(.system(size: 24, weight: .black, design: .rounded))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Text(description)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(.white.opacity(0.90))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

        }
    }
}

#Preview {
    ZStack {
        Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
        InfoView(
            icon: "dollarsign.circle.fill",
            title: "What is Compound Interest?",
            description: "Compound interest is interest calculated on both the initial principal and the accumulated interest. Your money earns money."
        )
    }
}
