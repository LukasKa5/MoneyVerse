//
//  XMarkView.swift
//  MoneyVerse
//
//  Created by Lukáš Kaniansky on 27/02/2026.
//

import SwiftUI

struct XMarkView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(12)
                        .clipShape(Circle())
                }
                .padding(.leading, 10)
                .padding(.top, 20)
                Spacer()
            }
            Spacer()
        }

    }
}

#Preview {
    XMarkView()
}
