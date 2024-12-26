// --------------------------------------------------
// OrganizationFilterRow.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct OrganizationFilterRow: View {
    
    var id: Int
    var name: String
    var reposCount: Int
    var isSelected: Bool
    var onTap: (() -> Void)
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.avenir(size: 16.0))
                    .foregroundStyle(Color.Text.primary)
                Text("filters.orgs.repos.\(reposCount)")
                    .font(.avenir(size: 12.0))
                    .foregroundStyle(Color.Text.primary)
            }
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundStyle(Color.Text.primary)
            }
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

struct OrganizationFilterRowPreview: PreviewProvider {
    
    static var previews: some View {
        OrganizationFilterRow(id: 1, name: "Name", reposCount: 123, isSelected: true, onTap: {})
            .previewLayout(.sizeThatFits)
    }
}