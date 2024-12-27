// --------------------------------------------------
// ToastViewModifier.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct ToastViewModifier: ViewModifier {
    
    @Binding var message: String?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                ZStack() {
                    if let message {
                        VStack() {
                            Spacer()
                            ToastView(message: message) {
                                hide()
                            }
                        }
                        .offset(y: -10.0)
                    }
                }
                .animation(.easeInOut, value: message)
            }
            .onChange(of: message) { _ in
                show()
            }
    }
    
    private func show() {
        guard message != nil else { return }
        workItem?.cancel()
        let workItem = DispatchWorkItem { hide() }
        self.workItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: workItem)
    }
    
    private func hide() {
        message = nil
        workItem?.cancel()
        workItem = nil
    }
}
