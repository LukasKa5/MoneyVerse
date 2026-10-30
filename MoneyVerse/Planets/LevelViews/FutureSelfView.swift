//
//  CalculatorView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 21/02/2026.
//

import SwiftUI

struct UserMilestone: Identifiable, Codable {
    let id: UUID
    var title: String
    var amount: Double
    var targetAge: Int
    var icon: String
    
    init(id: UUID = UUID(), title: String, amount: Double, targetAge: Int, icon: String) {
        self.id = id
        self.title = title
        self.amount = amount
        self.targetAge = targetAge
        self.icon = icon
    }
}

struct FutureSelfView: View {
    let onComplete: () -> Void
    
    @State private var currentAge: Double = 20
    @State private var monthlySaving: Double = 200
    @State private var annualReturn: Double = 7
    @State private var startingAmount: Double = 0
    @State private var phase: Phase = .input
    @State private var animatedWealth: Double = 0
    @State private var visibleMilestones: Int = 0
    
    @AppStorage("userMilestones") private var milestonesData: Data = Data()
    
    private var milestones: [UserMilestone] {
        get {
            (try? JSONDecoder().decode([UserMilestone].self, from: milestonesData)) ?? []
        }
        nonmutating set {
            milestonesData = (try? JSONEncoder().encode(newValue)) ?? Data()
        }
    }
    
    @State private var showingAddMilestone = false
    
    enum Phase { case input, result }
    private var isPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    
    
    private func wealth(atAge age: Int) -> Double {
        let years = max(0, age - Int(currentAge))
        let months = Double(years * 12)
        let r = annualReturn / 100 / 12
        
        if r == 0 {
            return startingAmount + (monthlySaving * months)
        }
        
        let futureStartingAmount = startingAmount * pow(1 + r, months)
        let futureSavings = monthlySaving * ((pow(1 + r, months) - 1) / r)
        
        return futureStartingAmount + futureSavings
    }
    
    private var finalWealth: Double { wealth(atAge: Int(currentAge) + 40) }
    
    private func extraWealthWith100More() -> Double {
        let years = 40
        let months = Double(years * 12)
        let r = annualReturn / 100 / 12
        let monthlyEnhanced = monthlySaving + 100
        
        if r == 0 {
            let totalEnhanced = startingAmount + (monthlyEnhanced * months)
            return totalEnhanced - finalWealth
        }
        
        let enhancedStarting = startingAmount * pow(1 + r, months)
        let enhancedSavings = monthlyEnhanced * ((pow(1 + r, months) - 1) / r)
        
        return (enhancedStarting + enhancedSavings) - finalWealth
    }
    
    private func formattedWealth(_ value: Double) -> String {
        if value >= 1_000_000 { return String(format: "%.1fM", value / 1_000_000) }
        if value >= 1000 { return String(format: "%.0fK", value / 1000) }
        return "\(Int(value))"
    }
    
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            
            if phase == .input {
                inputView
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading).combined(with: .opacity)))
            } else {
                resultView
                    .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .opacity))
            }
        }
        .animation(.spring(response: 0.5), value: phase)
        .sheet(isPresented: $showingAddMilestone) {
            MilestoneEditorView(currentAge: Int(currentAge)) { newMilestone in
                milestones.append(newMilestone)
                milestones.sort { $0.targetAge < $1.targetAge }
            }
        }
    }
    
    
    private var inputView: some View {
        ScrollView {
            VStack(spacing: 28) {
                VStack(spacing: 8) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 56))
                        .foregroundStyle(Color(red: 1.0, green: 0.85, blue: 0.3))
                        .padding(.top, 32)
                    Text("Your Future Self")
                        .font(.system(size: isPad ? 32 : 26, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                    Text("Set your details and your own goals.")
                        .font(.system(size: 15, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 24) {
                    FSSliderRow(label: "I am", value: $currentAge, range: 15...60, display: "\(Int(currentAge)) years old")
                    FSSliderRow(label: "I can save", value: $monthlySaving, range: 50...2000, display: "$\(Int(monthlySaving)) / month", step: 50)
                    FSSliderRow(label: "I already have", value: $startingAmount, range: 0...500000, display: "$\(Int(startingAmount))", step: 1000)
                    VStack(spacing: 10) {
                        FSSliderRow(label: "Annual return", value: $annualReturn, range: 1...15, display: "\(Int(annualReturn))%")
                        HStack {
                            Text("Conservative")
                            Spacer()
                            Text("S&P 500 ≈ 10%")
                            Spacer()
                            Text("Aggressive")
                        }
                        .font(.system(size: 10, weight: .medium, design: .monospaced))
                        .foregroundStyle(.white)
                    }
                }
                .padding(24)
                .background(.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .padding(.horizontal, 24)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("MY GOALS")
                            .font(.system(size: 11, weight: .heavy, design: .monospaced))
                            .foregroundStyle(.white)
                            .kerning(3)
                        Spacer()
                        Button { showingAddMilestone = true } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "plus").font(.system(size: 12, weight: .bold))
                                Text("ADD").font(.system(size: 11, weight: .heavy, design: .monospaced)).kerning(2)
                            }
                            .foregroundStyle(Color(red: 1.0, green: 0.85, blue: 0.3))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    if milestones.isEmpty {
                        Text("No goals yet, tap ADD to create your first goal")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.3))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                    } else {
                        ForEach(milestones) { milestone in
                            HStack(spacing: 14) {
                                ZStack {
                                    Circle()
                                        .fill(Color(red: 1.0, green: 0.85, blue: 0.3).opacity(0.12))
                                        .frame(width: 40, height: 40)
                                    Image(systemName: milestone.icon)
                                        .font(.system(size: 16))
                                        .foregroundStyle(Color(red: 1.0, green: 0.85, blue: 0.3))
                                }
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(milestone.title)
                                        .font(.system(size: 15, weight: .black, design: .rounded))
                                        .foregroundStyle(.white)
                                    Text("Age \(milestone.targetAge) · $\(formattedWealth(milestone.amount))")
                                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                                        .foregroundStyle(.white.opacity(0.6))
                                }
                                Spacer()
                                Button { milestones = milestones.filter { $0.id != milestone.id } } label: {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundStyle(.white.opacity(0.3))
                                        .padding(8)
                                        .background(.white.opacity(0.06))
                                        .clipShape(Circle())
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(.white.opacity(0.04))
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                    }
                }
                .padding(20)
                .background(.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .padding(.horizontal, 24)
                
                Button {
                    withAnimation { phase = .result }
                    animateResult()
                } label: {
                    Text("SHOW MY FUTURE")
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .kerning(1)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color(red: 1.0, green: 0.85, blue: 0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding(.horizontal, 24)
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 40)
            }
        }
    }
    
    private var resultView: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(spacing: 6) {
                    Text("By age \(Int(currentAge) + 40)")
                        .font(.system(size: 13, weight: .heavy, design: .monospaced))
                        .foregroundStyle(.white)
                        .kerning(3)
                        .padding(.top, 28)
                    Text("$\(formattedWealth(animatedWealth))")
                        .font(.system(size: isPad ? 60 : 48, weight: .black, design: .monospaced))
                        .foregroundStyle(Color(red: 1.0, green: 0.85, blue: 0.3))
                        .contentTransition(.numericText())
                        .animation(.spring(response: 0.3), value: animatedWealth)
                    Text("starting with $\(Int(startingAmount)) + $\(Int(monthlySaving))/mo at \(Int(annualReturn))% return")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("YOUR GOALS")
                        .font(.system(size: 11, weight: .heavy, design: .monospaced))
                        .foregroundStyle(.white)
                        .kerning(3)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)
                    
                    ForEach(Array(milestones.enumerated()), id: \.element.id) { index, milestone in
                        if index < visibleMilestones {
                            let wealth = wealth(atAge: milestone.targetAge)
                            FSMilestoneRow(milestone: milestone, isReachable: wealth >= milestone.amount, wealthAtAge: wealth)
                                .transition(.asymmetric(insertion: .move(edge: .trailing).combined(with: .opacity), removal: .opacity))
                        }
                    }
                    
                    if milestones.isEmpty {
                        Text("No goals set")
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundStyle(.white.opacity(0.6))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                    }
                }
                .padding(.vertical, 20)
                .background(.white.opacity(0.04))
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .padding(.horizontal, 24)
                
                VStack(spacing: 10) {
                    Text("WHAT IF YOU SAVED $100 MORE PER MONTH?")
                        .font(.system(size: 10, weight: .heavy, design: .monospaced))
                        .foregroundStyle(.white)
                        .kerning(2)
                        .multilineTextAlignment(.center)
                    Text("+$\(formattedWealth(extraWealthWith100More()))")
                        .font(.system(size: 32, weight: .black, design: .monospaced))
                        .foregroundStyle(Color(red: 0.1, green: 0.9, blue: 0.55))
                    Text("more by age \(Int(currentAge) + 40)")
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.white.opacity(0.04))
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                .padding(.horizontal, 24)
                
                Button {
                    withAnimation {
                        phase = .input
                        visibleMilestones = 0
                        animatedWealth = 0
                    }
                } label: {
                    Text("RECALCULATE")
                        .font(.system(size: 14, weight: .black, design: .rounded))
                        .kerning(1)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
    
    private func animateResult() {
        visibleMilestones = 0
        animatedWealth = 0
        let target = finalWealth
        for i in 0...40 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.04) {
                animatedWealth = target * Double(i) / 40
            }
        }
        for i in 0..<milestones.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4 + Double(i) * 0.2) {
                withAnimation(.spring(response: 0.4)) { visibleMilestones = i + 1 }
            }
        }
    }
}

private struct FSSliderRow: View {
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let display: String
    var step: Double = 1
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(label)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white)
                Spacer()
                Text(display)
                    .font(.system(size: 15, weight: .black, design: .monospaced))
                    .foregroundStyle(.white)
            }
            Slider(value: $value, in: range, step: step)
                .tint(Color(red: 1.0, green: 0.85, blue: 0.3))
        }
    }
}

private struct FSMilestoneRow: View {
    let milestone: UserMilestone
    let isReachable: Bool
    let wealthAtAge: Double
    
    private func fmt(_ value: Double) -> String {
        if value >= 1_000_000 { return String(format: "%.1fM", value / 1_000_000) }
        if value >= 1000 { return String(format: "%.0fK", value / 1000) }
        return "\(Int(value))"
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 2) {
                Text("AGE")
                    .font(.system(size: 8, weight: .heavy, design: .monospaced))
                    .foregroundStyle(.white.opacity(0.3))
                Text("\(milestone.targetAge)")
                    .font(.system(size: 16, weight: .black, design: .monospaced))
                    .foregroundStyle(.white)
            }
            .frame(width: 44)
            
            Rectangle()
                .fill(isReachable ? Color(red: 1.0, green: 0.85, blue: 0.3) : .white.opacity(0.1))
                .frame(width: 2, height: 52)
            
            ZStack {
                Circle()
                    .fill(isReachable ? Color(red: 1.0, green: 0.85, blue: 0.3).opacity(0.15) : .white.opacity(0.05))
                    .frame(width: 44, height: 44)
                Image(systemName: milestone.icon)
                    .font(.system(size: 18))
                    .foregroundStyle(isReachable ? Color(red: 1.0, green: 0.85, blue: 0.3) : .white.opacity(0.2))
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(milestone.title)
                    .font(.system(size: 15, weight: .black, design: .rounded))
                    .foregroundStyle(isReachable ? .white : .white.opacity(0.3))
                if isReachable {
                    Text("Goal: $\(fmt(milestone.amount)) — You'll have $\(fmt(wealthAtAge))")
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundStyle(Color(red: 0.1, green: 0.9, blue: 0.55))
                } else {
                    let shortfall = milestone.amount - wealthAtAge
                    let yearsLeft = max(1, milestone.targetAge - 20)
                    Text("Short by $\(fmt(shortfall)) — save $\(Int((shortfall / Double(yearsLeft * 12)).rounded(.up))) more/month")
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundStyle(.red.opacity(0.8))
                }
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
    }
}

struct MilestoneEditorView: View {
    let currentAge: Int
    let onSave: (UserMilestone) -> Void
    
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var amount: Double = 10000
    @State private var targetAge: Double
    @State private var selectedIcon = "star.fill"
    
    private let icons = ["car.fill", "house.fill", "graduationcap.fill",
                         "airplane", "heart.fill",
                         "gamecontroller.fill", "sun.horizon.fill",
                         "figure.run", "fork.knife"]
    
    init(currentAge: Int, onSave: @escaping (UserMilestone) -> Void) {
        self.currentAge = currentAge
        self.onSave = onSave
        _targetAge = State(initialValue: Double(currentAge + 5))
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Capsule()
                    .fill(.white.opacity(0.2))
                    .frame(width: 40, height: 4)
                    .padding(.top, 12)
                    .padding(.bottom, 24)
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Goal name")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                        TextField("e.g. Buy a House", text: $title)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(Color(red: 0.05, green: 0.05, blue: 0.1))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Amount needed")
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                            Spacer()
                            Text("$\(Int(amount))")
                                .font(.system(size: 15, weight: .black, design: .monospaced))
                                .foregroundStyle(.white)
                        }
                        Slider(value: $amount, in: 1000...1000000, step: 1000)
                            .tint(Color(red: 1.0, green: 0.85, blue: 0.3))
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("I want this by age")
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                                .foregroundStyle(.white)
                            Spacer()
                            Text("\(Int(targetAge))")
                                .font(.system(size: 15, weight: .black, design: .monospaced))
                                .foregroundStyle(.white)
                        }
                        Slider(value: $targetAge, in: Double(currentAge + 1)...Double(currentAge + 50), step: 1)
                            .tint(Color(red: 1.0, green: 0.85, blue: 0.3))
                    }
                    
                    
                    HStack {
                        
                        Text("Pick an icon")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        ForEach(icons, id: \.self) { icon in
                            Button { selectedIcon = icon } label: {
                                ZStack {
                                    Circle()
                                        .fill(selectedIcon == icon ? Color(red: 1.0, green: 0.85, blue: 0.3).opacity(0.2) : .white.opacity(0.06))
                                        .frame(width: 44, height: 44)
                                        .overlay(Circle().stroke(selectedIcon == icon ? Color(red: 1.0, green: 0.85, blue: 0.3) : .clear, lineWidth: 1.5))
                                    Image(systemName: icon)
                                        .font(.system(size: 16))
                                        .foregroundStyle(selectedIcon == icon ? Color(red: 1.0, green: 0.85, blue: 0.3) : .white.opacity(0.5))
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                Button {
                    guard !title.isEmpty else { return }
                    onSave(UserMilestone(title: title, amount: amount, targetAge: Int(targetAge), icon: selectedIcon))
                    dismiss()
                } label: {
                    Text("SAVE GOAL")
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .kerning(1)
                        .foregroundStyle(title.isEmpty ? .white.opacity(0.3) : .black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(title.isEmpty ? Color.white.opacity(0.08) : Color(red: 1.0, green: 0.85, blue: 0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding(.horizontal, 24)
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 32)
            }
        }
        .presentationDetents([.large])
        .presentationCornerRadius(28)
    }
}

#Preview {
    FutureSelfView(onComplete: {})
}
