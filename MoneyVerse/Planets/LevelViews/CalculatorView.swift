//
//  CalculatorView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 20/02/2026.
//

import SwiftUI

struct CalculatorView: View {
    let title: String
    let description: String
    let onComplete: () -> Void
    
    @State private var principal: Double = 1000
    @State private var rate: Double = 5
    @State private var years: Double = 10
    
    var isPad : Bool { UIDevice.current.userInterfaceIdiom == .pad }
    
    private var result: Double {
        principal * pow(1 + rate / 100, years)
    }
    private var gained: Double { result - principal }
    
    var body: some View {
        VStack {
            Text(description)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            VStack {
                Text("$\(Int(result))")
                    .font(.system(size: isPad ? 44 : 20, weight: .black, design: .monospaced))
                    .foregroundStyle(Color(red: 1.0, green: 0.85, blue: 0.3))
                Text("+$\(Int(gained)) earned")
                    .font(.system(size: isPad ? 14 : 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(red: 0.1, green: 0.9, blue: 0.55))
            }
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(.white.opacity(0.06))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.horizontal, 32)
            
            VStack {
                CalcSlider(label: "Starting Amount", value: $principal, range: 0...10000, unit: "$", step: 100)
                CalcSlider(label: "Annual Return Rate", value: $rate, range: 1...20, unit: "%", step: 1)
                CalcSlider(label: "Years", value: $years, range: 1...40, unit: " years", step: 1)
            }
            .padding(.horizontal, 32)
                        
            Button { onComplete() } label: {
                Text("NEXT PAGE")
                    .font(.system(size: 15, weight: .black, design: .rounded))
                    .kerning(1)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(red: 1.0, green: 0.85, blue: 0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .padding(.horizontal, 32)
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct CalcSlider: View {
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let unit: String
    let step: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.6))
                Spacer()
                Text("\(unit == "$" ? unit : "")\(Int(value))\(unit != "$" ? unit : "")")
                    .font(.system(size: 13, weight: .black, design: .monospaced))
                    .foregroundStyle(.white)
            }
            Slider(value: $value, in: range, step: step)
                .tint(Color(red: 1.0, green: 0.85, blue: 0.3))
        }
    }
}


#Preview {
    ZStack {
        Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
        CalculatorView(
            title: "Compound Interest Calculator",
            description: "See how your money grows over time. Adjust the sliders to explore.",
            onComplete: {}
        )
    }
}
