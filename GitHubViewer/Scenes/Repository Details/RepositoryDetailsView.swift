// --------------------------------------------------
// RepositoryDetailsView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct RepositoryDetailsView: View {
    
    // MARK: - Properties
    
    @ObservedObject var model = RepositoryDetailsModel()
    @Environment(\.openURL) private var openURL
    
    // MARK: - Initialisers
    
    init(repositoryID: Int) {
        model.repositoryID = repositoryID
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20.0) {
                VStack(spacing: 0.0) {
                    NavigationTintView(color: Color.Misc.navigationBar)
                    Divider()
                        .background(.ultraThinMaterial)
                }
                if let repository = model.repository {
                    if let description = repository.description {
                        Text(description)
                            .font(.avenir(size: 14.0))
                            .foregroundStyle(Color.Text.primary)
                            .padding(.horizontal, 10.0)
                    }
                    HStack {
                        if let language = repository.language {
                            TextPill(text: language)
                        }
                        Text(repository.size)
                            .font(.avenir(size: 12.0))
                            .foregroundStyle(Color.Text.primary)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            ForEach(repository.dates) {
                                Text($0.title)
                                    .font(.avenir(size: 14.0))
                                    .foregroundStyle(Color.Text.primary)
                            }
                        }
                        VStack(alignment: .leading) {
                            ForEach(repository.dates) {
                                Text($0.formattedDate)
                                    .font(.avenir(size: 14.0))
                                    .foregroundStyle(Color.Text.primary)
                            }
                        }
                    }
                    HStack(spacing: 10.0) {
                        DetailsCounterView(title: "repositoryDetails.text.stars", value: repository.starCount)
                        DetailsCounterView(title: "repositoryDetails.text.forks", value: repository.forksCount)
                        DetailsCounterView(title: "repositoryDetails.text.issues", value: repository.openIssuesCount)
                    }
                    .padding(.horizontal, 10.0)
                    HStack(spacing: 10.0) {
                        if let githubPage = repository.githubPage {
                            RoundedButton(title: "repositoryDetails.button.githubPage", onTap: { openURL(githubPage) })
                        }
                        if let homepage = repository.homepage {
                            RoundedButton(title: "repositoryDetails.button.homepage", onTap: { openURL(homepage) })
                        }
                    }
                    .padding(.horizontal, 10.0)

                } else {
                    Text("repositoryDetails.text.placeholder")
                        .font(.avenir(size: 18.0))
                        .foregroundStyle(Color.Text.primary)
                }
                Spacer()
            }
            .background(Color.Background.main)
            .navigationTitle(model.repository?.name ?? NSLocalizedString("repositoryDetails.title.placeholder", comment: ""))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RepositoryDetailsView(repositoryID: 1)
}
