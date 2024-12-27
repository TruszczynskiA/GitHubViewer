// --------------------------------------------------
// ToastView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct ToastView: View {
    
    var message: String
    var onClose: () -> Void
    
    var body: some View {
        HStack {
            Text(message)
                .font(.avenir(size: 14.0))
            Spacer(minLength: 10.0)
            Button(action: onClose) {
                Image(systemName: "xmark")
            }
        }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.Misc.error)
            .cornerRadius(10.0)
            .padding(.horizontal, 20.0)
    }
}

#Preview {
    ToastView(message: "I'm Error") {}
}
