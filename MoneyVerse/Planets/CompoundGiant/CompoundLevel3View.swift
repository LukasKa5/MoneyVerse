//
//  CompoundLevel3View.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct CompoundLevel3View: View {

    var body: some View {
        LevelContainerView(level: 3, surface: .compound, content: [
                    .info(icon: "brain.head.profile",
                          title: "What is Financial Stress?",
                          description: "Financial stress is the anxiety and worry that comes from struggling to manage money - whether it's debt, unexpected bills, or simply not having enough saved. It's one of the leading causes of sleep problems, relationship issues, and burnout."),
                    .info(icon: "",
                          title: "Fun Fact: Losses Hit Twice as Hard",
                          description: "Psychologists Daniel Kahneman and Amos Tversky discovered that losing $100 feels roughly twice as painful as gaining $100 feels good. This is called loss aversion. It's why financial stress hits so hard - our brains are literally wired to feel losses more intensely than wins. Knowing this can help you make calmer, more rational money decisions instead of panic-selling or avoiding your bank account."),
                    .info(icon: "gauge.with.dots.needle.67percent",
                          title: "The Stress-Debt Cycle",
                          description: "Financial stress often creates a vicious cycle - stress leads to impulsive spending as a coping mechanism, which creates more debt, which causes more stress. Recognizing this pattern is the first step to breaking it. Awareness alone can interrupt an automatic response."),
                    .quiz(question: "What is the most common trigger of financial stress?",
                          answers: ["Having too many investments", "Unexpected expenses with no emergency fund", "Earning a salary", "Owning a credit card"],
                          correctIndex: 1,
                          isLast: false),
                    .info(icon: "list.bullet.clipboard.fill",
                          title: "The Power of a Budget",
                          description: "A budget doesn't restrict your freedom - it gives you it. When you know exactly where your money goes, you stop dreading your bank statement. Even a rough plan like the 50/30/20 rule (50% needs, 30% wants, 20% savings) creates a sense of control that directly reduces anxiety."),
                    .slider(question: "How many months of expenses should your emergency fund cover?",
                            correctValue: 3,
                            unit: " months",
                            range: 1...12,
                            hint: "Most financial advisors recommend 3 to 6 months of living expenses as a safety net for unexpected events."),
                    .info(icon: "arrow.counterclockwise.circle.fill",
                          title: "Tackling Debt Without Panic",
                          description: "If debt is your main stressor, two proven methods can help. The Snowball method pays off your smallest debt first for quick psychological wins. The Avalanche method targets the highest interest debt first to save the most money long term. Either beats doing nothing - pick the one you'll actually stick to."),
                    .info(icon: "heart.fill",
                          title: "Money and Mental Health",
                          description: "Financial stress isn't just a money problem - it's a wellbeing problem. Studies show people under financial stress are 3x more likely to experience depression. Talking to someone, whether a financial advisor, therapist, or trusted friend, is not a sign of failure. It's one of the most effective things you can do."),
                    .quiz(question: "First step of reducing financial stress should be?",
                          answers: ["Earn more money immediately", "Ignore the problem and hope it improves", "Get a clear picture of your income, spending, and debts", "Cut all spending entirely"],
                          correctIndex: 2,
                          isLast: true)
                ])
    }
}

#Preview {
    CompoundLevel3View()
}
