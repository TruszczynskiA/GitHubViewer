// --------------------------------------------------
// View+Utils.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

extension View {
    
    func toast(message: Binding<String?>) -> some View {
        modifier(ToastViewModifier(message: message))
    }
}
