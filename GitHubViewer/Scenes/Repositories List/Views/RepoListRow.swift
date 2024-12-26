// --------------------------------------------------
// RepoListRow.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct RepoListRow: View {
    
    var name: String
    var organizationName: String
    var description: String?
    var language: String?
    var starsCount: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(name)
                .font(.avenir(size: 16.0))
                .foregroundStyle(Color.Text.primary)
            Text(organizationName)
                .font(.avenir(size: 14.0))
                .foregroundStyle(Color.Text.primary)
            if let description {
                Text(description)
                    .font(.avenir(size: 12.0))
                    .foregroundStyle(Color.Text.secondary)
            }
            HStack(alignment: .bottom) {
                if let language {
                    Text(language)
                        .font(.avenir(size: 13.0))
                        .foregroundStyle(.black)
                        .padding(EdgeInsets(top: 5.0, leading: 8.0, bottom: 5.0, trailing: 8.0))
                        .background(Color.Background.language)
                        .cornerRadius(8.0)
                }
                Spacer()
                HStack(spacing: 0.0) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 13.0, height: 13.0)
                        .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 2.0, trailing: 2.0))
                        .foregroundStyle(Color.Text.primary)
                    Text(starsCount)
                        .font(.avenir(size: 13.0))
                        .foregroundStyle(Color.Text.primary)
                        .padding(0.0)
                }
            }
        }
        .padding(EdgeInsets(top: 8.0, leading: 12.0, bottom: 8.0, trailing: 12.0))
    }
}

struct RepoListRowPreviews: PreviewProvider {
    
    static var previews: some View {
        RepoListRow(
            name: "Name",
            organizationName: "Organization Name",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            language: "Swift",
            starsCount: "123"
        )
        .previewLayout(.sizeThatFits)
    }
}
