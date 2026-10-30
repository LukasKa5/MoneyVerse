//
//  CalculatorView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 20/02/2026.
//

import SwiftUI

enum LevelContent {
    case info(icon: String, title: String, description: String)
    case quiz(question: String, answers: [String], correctIndex: Int, isLast: Bool)
    case slider(question: String, correctValue: Double, unit: String, range: ClosedRange<Double>, hint: String)
    case calculator(title: String, description: String)
}

struct LevelContainerView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var manager = LevelManager.shared

    let level: Int
    let surface: SurfaceID
    let content: [LevelContent]

    @State private var currentPage = 0

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            XMarkView()

            VStack(spacing: 0) {
                HStack(spacing: 6) {
                        ForEach(0..<content.count, id: \.self) { i in
                            Capsule()
                                .fill(i == currentPage ? Color(red: 1.0, green: 0.85, blue: 0.3) : .white.opacity(0.25))
                                .frame(width: i == currentPage ? 20 : 6, height: 6)
                                .animation(.spring(response: 0.3), value: currentPage)
                        }
                    }
                    .padding(.top, 20)
                    Color.clear.frame(width: 34, height: 34)
                    

                TabView(selection: $currentPage) {
                    ForEach(0..<content.count, id: \.self) { i in
                        pageView(for: content[i], index: i)
                            .tag(i)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                if shouldShowNextButton {
                    Button {
                        if currentPage + 1 >= content.count {
                            manager.completeLevel(level, surface: surface)
                            dismiss()
                        } else {
                            withAnimation { currentPage += 1 }
                        }
                    } label: {
                        Text(nextButtonLabel)
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
                    .padding(.bottom, 32)
                    .transition(.opacity)
                }
            }
        }
    }

    private var shouldShowNextButton: Bool {
        guard currentPage < content.count else { return false }
        if case .info = content[currentPage] { return true }
        return false
    }

    private var nextButtonLabel: String {
        let nextIndex = currentPage + 1
        guard nextIndex < content.count else { return "FINISH QUIZ"  }
        switch content[nextIndex] {
        case .quiz: return "TAKE THE QUIZ"
        case .slider, .calculator: return "TRY IT OUT"
        default: return "NEXT"
        }
    }

    @ViewBuilder
    private func pageView(for item: LevelContent, index: Int) -> some View {
        switch item {
        case .info(let icon, let title, let description):
            InfoView(icon: icon, title: title, description: description)

        case .quiz(let question, let answers, let correctIndex, let isLast):
            QuizView(question: question, answers: answers, correctIndex: correctIndex, isLast: isLast) {
                manager.completeLevel(level, surface: surface)
                if isLast {
                    dismiss()
                }
                withAnimation { currentPage += 1 }
            }

        case .slider(let question, let correctValue, let unit, let range, let hint):
            SliderQuestionView(question: question, correctValue: correctValue, unit: unit, range: range, hint: hint) {
                withAnimation { currentPage += 1 }
            }

        case .calculator(let title, let description):
            CalculatorView(title: title, description: description) {
                withAnimation { currentPage += 1 }
            }
        }
    }
}
