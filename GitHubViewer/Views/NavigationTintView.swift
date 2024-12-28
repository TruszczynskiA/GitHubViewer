// --------------------------------------------------
// NavigationTintView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct NavigationTintView: View {
    
    let color: Color

    var body: some View {
        Rectangle()
            .frame(height: 0.2)
            .background(color)
    }
}

#Preview {
    NavigationTintView(color: Color.red)
}
