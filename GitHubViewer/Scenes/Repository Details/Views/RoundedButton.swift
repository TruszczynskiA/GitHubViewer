// --------------------------------------------------
// RoundedButton.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct RoundedButton: View {
    
    let title: LocalizedStringKey
    let onTap: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: onTap) {
                Text(title)
                    .font(.avenir(size: 14.0))
                    .foregroundStyle(Color.Text.primary)
            }
            Spacer()
        }
        .padding()
        .background(Color.Misc.button)
        .cornerRadius(10.0)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RoundedButton(title: "Title", onTap: {})
}
