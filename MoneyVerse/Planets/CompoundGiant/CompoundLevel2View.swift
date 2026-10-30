//
//  CompoundLevel2View.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct CompoundLevel2View: View {

    var body: some View {
        LevelContainerView(level: 2, surface: .compound, content: [
                .info(icon: "clock.arrow.2.circlepath",
                        title: "Why Time is Your Biggest Asset",
                        description: "The secret ingredient in compounding isn't how much you invest - it's how long you invest for. Starting at 20 vs 30 can mean hundreds of thousands of dollars difference by retirement, even with identical monthly contributions. Time in the market always beats timing the market."),
                  .info(icon: "person.2.fill",
                        title: "The Tale of Two Investors",
                        description: "Anna invests $200/month starting at age 20 and stops at 30 - then never invests again. Ben starts at 30 and invests $200/month all the way until he's 60. Despite investing for only 10 years, Anna ends up with more money than Ben who invested for 30 years. That's the power of starting early."),
                  .calculator(title: "Compound Interest Calculator",
                              description: "See how time transforms your money. Try setting 40 years at 10% return, the result might surprise you."),
                  .info(icon: "calendar.badge.clock",
                        title: "The Cost of Waiting",
                        description: "Every year you delay investing has a compounding cost. Waiting just 5 years to start can reduce your final wealth by 40% or more. The best time to start was yesterday. The second best time is today, even with a small amount. Consistency matters far more than the size of your contributions."),
                  .quiz(question: "What best maximizes compound interest?",
                        answers: ["Picking the perfect stock", "Investing a large lump sum", "Starting as early as possible", "Checking your portfolio daily"],
                        correctIndex: 2,
                        isLast: true)
                ])
    }
}

#Preview {
    CompoundLevel2View()
}
