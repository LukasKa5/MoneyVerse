//
//  DebtLevel2View.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct DebtLevel2View: View {

    var body: some View {
        LevelContainerView(level: 2, surface: .debt, content: [
                    .info(icon: "creditcard.fill",
                          title: "What is a Credit Score?",
                          description: "A credit score is a number that represents how trustworthy you are as a borrower. Lenders worldwide use it to decide whether to give you a loan - and at what interest rate. The exact scale varies by country, but the principle is universal: a higher score means better rates, which can save you tens of thousands over a lifetime."),
                    .info(icon: "globe.fill",
                          title: "It's a Global System",
                          description: "Almost every country has its own credit scoring system. The US uses FICO (300–850). The UK uses Experian (0–999). Canada uses TransUnion and Equifax. Germany has SCHUFA. Australia has Equifax too. The names and scales differ, but the underlying logic is identical everywhere, your borrowing history determines your financial reputation."),
                    .info(icon: "list.number",
                          title: "What Makes Up Your Score?",
                          description: "Regardless of country, scores are built from the same five pillars: payment history - the most important factor, whether you pay on time. Credit utilization - how much of your available credit you use. Length of credit history. Mix of credit types. And how often you apply for new credit. Master these and you master your score anywhere in the world."),
                    .quiz(question: "Which factor has the biggest impact on credit score?",
                          answers: ["How many credit cards you have", "Your income level", "Payment history", "Your age"],
                          correctIndex: 2,
                          isLast: false),
                    .info(icon: "chart.pie.fill",
                          title: "What is Credit Utilization?",
                          description: "Credit utilization is the percentage of your available credit that you're currently using. If your credit card limit is $1,000 and you've spent $300, your utilization is 30%. Lenders see high utilization as a sign of financial stress - like you're constantly living at the edge of what you can borrow. Keeping it low signals that you're in control of your finances."),
                    .slider(question: "Healthy credit utilization should stay below what percent?",
                            correctValue: 30,
                            unit: "%",
                            range: 10...90,
                            hint: "Financial advisors universally recommend keeping your credit card balances below 30% of your total limit. Below 10% is even better for maximizing your score."),
                    .info(icon: "arrow.up.circle.fill",
                          title: "How to Improve Your Score — Anywhere",
                          description: "The rules are the same globally: pay every bill on time, even one missed payment can drop your score significantly. Keep balances low relative to your limit. Don't close old accounts. Avoid applying for multiple credit products at once. And check your report regularly for errors - most countries give you at least one free report per year."),
                    .info(icon: "dollarsign.circle.fill",
                          title: "Why It Costs You Real Money",
                          description: "A poor credit score doesn't just affect loan approval, it also affects the rate you pay. On a large mortgage, the difference between a poor and excellent score can mean a 1–2% higher interest rate, costing you the equivalent of a new car in extra interest. Your credit score is one of the most valuable numbers in your financial life."),
                    .quiz(question: "What is the most effective habit for building a strong credit score over time?",
                          answers: ["Open as many new accounts as possible", "Pay all bills on time every month", "Close all unused credit cards immediately", "Avoid using credit entirely"],
                          correctIndex: 1,
                          isLast: true)
                ])
    }
}

#Preview {
    DebtLevel2View()
}
