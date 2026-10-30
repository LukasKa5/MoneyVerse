//
//  DebtLevel1View.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct DebtLevel1View: View {

    var body: some View {
        LevelContainerView(level: 1, surface: .debt, content: [
                    .info(icon: "scalemass.fill",
                          title: "Not All Debt is Equal",
                          description: "Debt has a bad reputation - but the truth is, some debt can actually help you build wealth. The key is knowing the difference between debt that works for you and debt that works against you."),
                    .info(icon: "arrow.up.circle.fill",
                          title: "What is Good Debt?",
                          description: "Good debt helps you build long-term value or increase your earning potential. A student loan that leads to a higher salary, a mortgage on a home that appreciates, or a business loan that generates profit - these are investments in your future. The interest rates are typically low and the return outweighs the cost."),
                    .quiz(question: "Which of these is the best example of good debt?",
                          answers: ["A payday loan to cover rent", "A credit card balance from shopping", "A student loan for a high-demand degree", "Borrowing to buy a new TV"],
                          correctIndex: 2,
                          isLast: false),
                    .info(icon: "arrow.down.circle.fill",
                          title: "What is Bad Debt?",
                          description: "Bad debt is borrowed money spent on things that lose value immediately or have no return. Credit card debt at 20% interest, payday loans, or financing a luxury you can't afford - these drain your finances. The item depreciates while the interest compounds against you."),
                    .slider(question: "The average credit card interest rate in the US is around what percent?",
                            correctValue: 20,
                            unit: "%",
                            range: 5...35,
                            hint: "Credit card APRs in the US average around 20-24%. At this rate, a $1,000 balance takes years to pay off if you only make minimum payments."),
                    .info(icon: "lightbulb.fill",
                          title: "The Golden Rule of Debt",
                          description: "Before taking on any debt, ask yourself two questions: Will this increase my net worth or earning potential? And is the interest rate lower than the return I'll get? If both answers are yes, it may be good debt. If not, think twice."),
                ])
    }
}

#Preview {
    DebtLevel1View()
}
