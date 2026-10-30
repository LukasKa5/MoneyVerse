//
//  QuizView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct QuizView: View {
    let question: String
    let answers: [String]
    let correctIndex: Int
    let isLast: Bool
    let onComplete: () -> Void

    @State private var selected: Int? = nil
    @State private var showResult = false
    
    var isPad : Bool { UIDevice.current.userInterfaceIdiom == .pad }

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "questionmark.circle.fill")
                .font(.system(size: isPad ? 48 : 32))
                .foregroundStyle(Color(red: 1.0, green: 0.85, blue: 0.3))

            Text(question)
                .font(.system(size: 20, weight: .black, design: .rounded))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            VStack(spacing: 12) {
                ForEach(0..<answers.count, id: \.self) { i in
                    Button {
                        guard selected == nil else { return }
                        selected = i
                        showResult = true
                        if i == correctIndex {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                onComplete()
                            }
                        }
                    } label: {
                        HStack {
                            Text(answers[i])
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .foregroundStyle(answerTextColor(i))
                            Spacer()
                            if showResult && i == selected {
                                Image(systemName: i == correctIndex ? "checkmark" : "xmark")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundStyle(answerTextColor(i))
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .background(answerBackground(i))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 32)
                }
            }

            if showResult && selected != correctIndex {
                Text("Try again!")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(.red.opacity(0.8))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            selected = nil
                            showResult = false
                        }
                    }
            }

            Spacer()
        }
        .padding(.top, 16)
    }

    private func answerBackground(_ i: Int) -> Color {
        guard showResult, let s = selected else { return .white.opacity(0.08) }
        if i == s && i == correctIndex { return Color.green.opacity(0.25) }
        if i == s && i != correctIndex { return Color.red.opacity(0.25) }
        return .white.opacity(0.08)
    }

    private func answerTextColor(_ i: Int) -> Color {
        guard showResult, let s = selected else { return .white }
        if i == s && i == correctIndex { return Color(red: 0.1, green: 0.9, blue: 0.55) }
        if i == s && i != correctIndex { return .red }
        return .white
    }
}


#Preview {
    ZStack {
        Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
        QuizView(
            question: "What makes compound interest different from simple interest?",
            answers: [
                "It only applies to savings accounts",
                "It earns interest on interest",
                "It has a higher fixed rate",
                "It requires a minimum balance"
            ],
            correctIndex: 1,
            isLast: false,
            onComplete: {}
        )
    }
}
