//
//  InflationLevel2View.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct InflationLevel2View: View {

    var body: some View {
        LevelContainerView(level: 2, surface: .inflation, content: [
            .info(icon: "building.columns.fill",
                  title: "What is a Stock?",
                  description: "A stock represents a small ownership stake in a company. When the company grows and earns more, your stock becomes more valuable. But if the company struggles, its value can drop, so stocks carry risk alongside their potential reward."),
            .info(icon: "arrow.up.forward",
                  title: "Making Money Through Price Growth",
                  description: "The most common way to profit from stocks is simply buying low and selling high. If you buy a share of Apple for $150 and it rises to $200, you've made $50 per share. This is called capital gain. The catch is that prices can also fall, so timing and patience matter, most long-term investors hold for years rather than trying to predict short-term moves."),
            
            .info(icon: "",
                  title: "Making Money Through Dividends",
                  description: "Some companies share a portion of their profits directly with shareholders - this is called a dividend. For example, if you own 10 shares and the company pays a $2 dividend per share, you receive $20 cash without selling anything. Dividend stocks like Coca-Cola or Johnson & Johnson are popular with investors who want a steady income stream rather than just price growth."),
            .quiz(question: "What do you actually own when you buy a stock?",
                  answers: ["A loan given to the company", "A small piece of ownership in the company", "A guaranteed annual payment", "Access to the company's products for free"],
                  correctIndex: 1,
                  isLast: false),
            .info(icon: "doc.text.fill",
                  title: "What is a Bond?",
                  description: "A bond is essentially a loan you give to a company or government. In return, they pay you regular interest and return your money at the end of a set period. Bonds are generally safer than stocks but offer lower returns."),
            .slider(question: "A 10-year US Treasury bond average annual return?",
                    correctValue: 4,
                    unit: "%",
                    range: 1...10,
                    hint: "US Treasury bonds have historically yielded between 2–5%. Currently around 4% for a 10-year bond."),
            .info(icon: "square.grid.2x2.fill",
                  title: "What is an ETF?",
                  description: "An ETF (Exchange-Traded Fund) is a basket of many stocks or bonds bundled into one investment. Instead of picking individual companies, you buy a slice of hundreds at once. This spreads your risk and makes diversification easy and affordable."),
            .info(icon: "",
                  title: "Why Diversification Matters",
                  description: "Imagine putting all your money into one company, if it collapses, you lose everything. Diversification means spreading your money across different stocks, sectors, and asset types so that one bad investment doesn't sink your entire portfolio. It's the investing equivalent of not putting all your eggs in one basket. Historically, diversified portfolios recover from crashes far faster than concentrated ones."),
            .quiz(question: "Why might an ETF be better than picking individual stocks?",
                  answers: ["ETFs always guarantee profit", "ETFs are only available to professionals", "ETFs spread risk across many companies at once", "ETFs have no fees whatsoever"],
                  correctIndex: 2,
                  isLast: false),
            .info(icon: "iphone.fill",
                  title: "How to Buy Stocks, ETFs & Bonds",
                  description: "All three are bought through a brokerage app - popular beginner-friendly options include Robinhood, Fidelity, and Trading 212 and others. You open an account, deposit money, and search by ticker symbol: AAPL for Apple stock, SPY for an S&P 500 ETF, or TLT for long-term US Treasury bonds. Stocks and ETFs trade instantly like a store purchase. Bonds can also be bought directly from governments. Most platforms have no trading fees (but be aware of other fees and check them!) and allow fractional shares from as little as $1."),
        ])
    }
}

#Preview {
    InflationLevel2View()
}
