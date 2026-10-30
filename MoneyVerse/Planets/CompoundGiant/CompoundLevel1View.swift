//
//  CompoundLevel1View.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct CompoundLevel1View: View {
    
    var body: some View {
        LevelContainerView(level: 1, surface: .compound, content: [
                    .info(icon: "text.book.closed",
                          title: "The Eighth Wonder of the World",
                          description: "Albert Einstein allegedly called compound interest the eighth wonder of the world - 'He who understands it, earns it. He who doesn't, pays it.' Compound interest means you earn interest not just on your original money, but also on the interest you've already earned. Over time, this creates exponential growth."),
                    .info(icon: "percent",
                          title: "Simple vs Compound Interest",
                          description: "With simple interest, you earn interest only on your original amount. If you invest $1,000 at 10%, you earn $100 every year - always the same. With compound interest, that $100 gets added to your balance, so next year you earn 10% on $1,100. The year after, on $1,210."),
                    .quiz(question: "What makes compound interest different from simple interest?",
                          answers: ["It has a higher fixed rate", "It only applies to savings accounts", "You earn interest on your interest", "It requires a minimum balance"],
                          correctIndex: 2,
                          isLast: false),
                    .info(icon: "chart.line.uptrend.xyaxis",
                          title: "The Snowball Effect",
                          description: "Compound interest grows slowly at first - almost invisibly. But after 10, 20, 30 years it accelerates dramatically. This is called exponential growth. The longer you leave it, the faster it grows. The last 10 years of a 40-year investment often produce more wealth than the first 30 years combined."),
                    .quiz(question: "Why does compound interest grow faster over time?",
                          answers: ["Interest rates increase automatically", "Banks reward loyal customers", "Your balance grows, so interest is calculated on a bigger amount each year", "Inflation reduces your costs"],
                          correctIndex: 2,
                          isLast: true)
        ])
    }
}

#Preview {
    CompoundLevel1View()
}
