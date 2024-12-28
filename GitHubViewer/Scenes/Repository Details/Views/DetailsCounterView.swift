// --------------------------------------------------
// DetailsCounterView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct DetailsCounterView: View {
    
    let title: LocalizedStringKey
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.avenir(size: 14.0))
                .foregroundStyle(Color.Text.primary)
            Text(value)
                .font(.avenir(size: 14.0))
                .foregroundStyle(Color.Text.primary)
        }
        .frame(maxWidth: .infinity)
    }
}
