// --------------------------------------------------
// TextPill.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct TextPill: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(.avenir(size: 13.0))
            .foregroundStyle(.black)
            .padding(EdgeInsets(top: 5.0, leading: 8.0, bottom: 5.0, trailing: 8.0))
            .background(Color.Background.language)
            .cornerRadius(8.0)
    }
}


#Preview {
    TextPill(text: "Message")
}
