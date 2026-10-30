//
//  InflationLevel3View.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct InflationLevel3View: View {

    var body: some View {
        LevelContainerView(level: 3, surface: .inflation, content: [
                    .info(icon: "leaf.fill",
                          title: "What is Sustainable Investing?",
                          description: "Sustainable investing means choosing investments not just for financial return, but also based on a company's impact on the environment, society, and how well it's governed. This approach is often called ESG investing."),
                    .info(icon: "globe.europe.africa.fill",
                          title: "What Does ESG Stand For?",
                          description: "E stands for Environmental - how a company treats the planet. S stands for Social - how it treats people, workers, and communities. G stands for Governance - how it's led and whether it's run ethically and transparently."),
                    .info(icon: "magnifyingglass.circle.fill",
                          title: "Where to Find ESG Investments",
                          description: "Most brokerages like Fidelity and Vanguard offer ESG fund screeners. For research, Morningstar rates thousands of funds on sustainability. Popular ESG ETFs include ESGU, ESGV, and ICLN - which focuses purely on clean energy. Look for low fees and check what the fund actually holds, as ESG standards vary between providers."),
                    .quiz(question: "A company uses renewable energy. Which ESG pillar?",
                          answers: ["Social", "Governance", "Environmental", "None of the above"],
                          correctIndex: 2,
                          isLast: false),
                    .info(icon: "questionmark",
                          title: "Does ESG Mean Lower Returns?",
                          description: "Not necessarily. Many ESG funds perform comparably to traditional ones. Companies with strong ESG practices often face fewer scandals, regulatory fines, and long-term risks, which can actually make them more stable investments."),
                    .quiz(question: "Which of these is an example of poor Governance (the G in ESG)?",
                          answers: ["A CEO who reduces company emissions", "A board that hides financial losses from investors", "A firm that pays workers above minimum wage", "A company switching to solar energy"],
                          correctIndex: 1,
                          isLast: true)
                ])
    }
}

#Preview {
    InflationLevel3View()
}
