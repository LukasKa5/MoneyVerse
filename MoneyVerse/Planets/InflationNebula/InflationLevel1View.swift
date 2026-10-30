//
//  InflationLevel1View.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct InflationLevel1View: View {

    var body: some View {
        LevelContainerView(level: 1, surface: .inflation, content: [
                    .info(icon: "chart.line.uptrend.xyaxis",
                          title: "What is Inflation?",
                          description: "Inflation is the gradual rise in the price of goods and services over time. When inflation is high, your money buys less than it did before. A coffee that cost $2 in 2010 might cost $4 today. It's one of the most important forces shaping your financial life."),
                    .info(icon: "dollarsign.arrow.circlepath",
                          title: "Why Does Inflation Happen?",
                          description: "Inflation occurs when there's too much money chasing too few goods. This can happen when governments print more money, when demand for products surges, or when production costs rise - like when oil prices spike and everything that needs shipping gets more expensive."),
                    .quiz(question: "If inflation is 5% this year, what happens to your $100 in cash?",
                          answers: ["It grows to $105", "It can still buy exactly the same things", "It can now only buy what $95 could before", "It doubles in value"],
                          correctIndex: 2,
                          isLast: false),
                    .slider(question: " What inflation is considered 'healthy'?",
                            correctValue: 2,
                            unit: "%",
                            range: 0...10,
                            hint: "Central banks consider 2% a healthy, stable rate — high enough to encourage spending, low enough to preserve purchasing power."),
                    .info(icon: "building.2.fill",
                          title: "How is Inflation Measured?",
                          description: "Governments track inflation using the Consumer Price Index (CPI) - a basket of everyday items like food, rent, transport, and clothing. Each month they check how much that basket costs compared to last year. If it's more expensive, inflation is up."),
                    .quiz(question: "Which of these would most likely cause inflation to rise?",
                          answers: ["A government cuts spending significantly", "A central bank raises interest rates", "A country prints large amounts of new money", "Consumer demand drops sharply"],
                          correctIndex: 2,
                          isLast: false),
                    .info(icon: "person.fill.checkmark",
                          title: "How Inflation Affects You",
                          description: "If your salary doesn't grow as fast as inflation, you're effectively earning less every year. Cash sitting in a low-interest account loses real value over time. This is why investing matters - assets like stocks and real estate have historically grown faster than inflation, protecting your purchasing power."),
                    .quiz(question: "Best way to protect your money from losing value?",
                          answers: ["Keep it all in cash under a mattress", "Put it in a savings account with 1% interest", "Invest in assets that historically outpace inflation", "Spend it all immediately before prices rise"],
                          correctIndex: 2,
                          isLast: true)
                ])
    }
}

#Preview {
    InflationLevel1View()
}
