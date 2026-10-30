//
//  DebtLevel3View.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct DebtLevel3View: View {

    var body: some View {
        LevelContainerView(level: 3, surface: .debt, content: [
                    .info(icon: "house.fill",
                          title: "The Housing Crisis Explained",
                          description: "In many cities, home prices have skyrocketed while wages haven't kept up. Supply of homes is low, demand is high, and mortgage rates have surged, making buying a home feel impossible for an entire generation. Understanding the system is the first step to navigating it."),
                    .info(icon: "arrow.up.right.circle.fill",
                          title: "Why Are Homes So Expensive?",
                          description: "Three forces drive high prices: limited supply (not enough homes being built), high demand (population growth, remote work relocations), and rising mortgage rates which increase your monthly payment even if the home price stays flat. In some cities, home prices have doubled in under a decade."),
                    .slider(question: "A typical down payment on a home in the US is what percent of the purchase price?",
                            correctValue: 20,
                            unit: "%",
                            range: 3...30,
                            hint: "The traditional down payment is 20%, though first-time buyer programs can go as low as 3-5%. A higher down payment means lower monthly payments and no PMI insurance."),
                    .info(icon: "chart.bar.fill",
                          title: "Renting vs Buying — It's Not Simple",
                          description: "Buying isn't always smarter than renting. If you plan to move within 5 years, renting often wins financially. Homeownership comes with mortgage interest, property taxes, maintenance, and insurance. The '5 Year Rule' suggests you need to stay put for at least 5 years for buying to beat renting financially."),
                    .info(icon: "hammer.fill",
                          title: "How to Fight Back",
                          description: "You can stack the odds in your favor. Save aggressively for a down payment using a dedicated high-yield savings account. Look into first-time buyer programs - many offer reduced rates or down payment assistance. Consider up-and-coming neighborhoods before they peak."),
                    .info(icon: "newspaper",
                          title: "Afford It on Paper First",
                          description: "A common rule is to spend no more than 30% of your gross monthly income on housing costs. If you earn $5,000/month, your mortgage, taxes, and insurance combined should stay under $1,400. Going above this strains your budget and leaves no room for emergencies or savings."),
                    .info(icon: "person.crop.circle.fill",
                          title: "Plan Your Future Home",
                          description: "Knowing the rules is one thing - seeing your own numbers is another. Use the Future Self tool in top right corner of menu to set a home purchase as a goal, pick your target age, and find out exactly how much you need to save each month to get there.")
                    
                ])
    }
}

#Preview {
    DebtLevel3View()
}
