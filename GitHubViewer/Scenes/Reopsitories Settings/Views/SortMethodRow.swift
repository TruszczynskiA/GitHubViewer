// --------------------------------------------------
// SortMethodRow.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct SortMethodRow: View {
    
    // MARK: - Properties
    
    let title: String
    let isSelected: Bool
    let onTap: (() -> Void)
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Text(title)
                .font(.avenir(size: 16.0))
                .foregroundStyle(Color.Text.primary)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundStyle(Color.Text.primary)
            }
        }
        .padding(.vertical, 5.0)
        .padding(.horizontal, 12.0)
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    SortMethodRow(title: "Title", isSelected: true, onTap: {})
}
