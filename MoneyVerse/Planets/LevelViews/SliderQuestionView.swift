//
//  SliderQuestionView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct SliderQuestionView: View {
    let question: String
    let correctValue: Double
    let unit: String
    let range: ClosedRange<Double>
    let hint: String
    let onComplete: () -> Void
    
    var isPad : Bool { UIDevice.current.userInterfaceIdiom == .pad }
    
    @State private var sliderValue: Double
    @State private var submitted = false
    @State private var isCorrect = false
    
    init(question: String, correctValue: Double, unit: String, range: ClosedRange<Double>, hint: String, onComplete: @escaping () -> Void) {
        self.question = question
        self.correctValue = correctValue
        self.unit = unit
        self.range = range
        self.hint = hint
        self.onComplete = onComplete
        _sliderValue = State(initialValue: (range.lowerBound + range.upperBound) / 2)
    }
    
    private var tolerance: Double { (range.upperBound - range.lowerBound) * 0.15 }
    private var isClose: Bool { abs(sliderValue - correctValue) <= tolerance }
    
    var body: some View {
        VStack(spacing: 28) {
            
            Text(question)
                .font(.system(size: isPad ? 20 : 16, weight: .black, design: .rounded))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Text("\(Int(sliderValue))\(unit)")
                .font(.system(size: isPad ? 52 : 32, weight: .black, design: .monospaced))
                .foregroundStyle(submitted ? (isClose ? Color(red: 0.1, green: 0.9, blue: 0.55) : .red) : Color(red: 1.0, green: 0.85, blue: 0.3))
                .animation(.spring(response: 0.3), value: submitted)
            
            Slider(value: $sliderValue, in: range, step: 1)
                .tint(Color(red: 1.0, green: 0.85, blue: 0.3))
                .padding(.horizontal, 32)
                .disabled(submitted)
            
            HStack {
                Text("\(Int(range.lowerBound))\(unit)")
                Spacer()
                Text("\(Int(range.upperBound))\(unit)")
            }
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(.white.opacity(0.7))
            .padding(.horizontal, 36)
            
            if submitted {
                if isClose {
                    Text("Great job, you were close enough! The exact answer was \(Int(correctValue))\(unit)")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(isClose ? Color(red: 0.1, green: 0.9, blue: 0.55) : .red)
                }
            }
            
            Spacer()
            
            if !submitted {
                Button {
                    withAnimation {
                        submitted = true;
                        isCorrect = isClose
                    }
                    if isClose {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { onComplete() }
                    }
                } label: {
                    Text("SUBMIT")
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .kerning(1)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(red: 1.0, green: 0.85, blue: 0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 32)
                .buttonStyle(PlainButtonStyle())
            } else if !isClose {
                Button {
                    withAnimation { submitted = false; sliderValue = (range.lowerBound + range.upperBound) / 2 }
                } label: {
                    Text("TRY AGAIN")
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .kerning(1)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(.red.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding(.horizontal, 32)
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
}

#Preview {
    ZStack {
        Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
        SliderQuestionView(
            question: "What is the average annual return of the S&P 500?",
            correctValue: 10,
            unit: "%",
            range: 0...30,
            hint: "The S&P 500 has historically returned about 10% per year on average.",
            onComplete: {}
        )
    }
}

