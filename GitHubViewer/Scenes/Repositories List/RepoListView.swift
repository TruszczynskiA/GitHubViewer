// --------------------------------------------------
// RepoListView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct RepoListView: View {
    
    enum Sheet: Identifiable {
        case filters
        case repositoryDetails(repositoryID: Int)
        
        var id: Int {
            switch self {
            case .filters:
                return 0
            case .repositoryDetails:
                return 1
            }
        }
    }
    
    // MARK: - Properties
    
    @StateObject var model = RepoListModel(apiManager: GitHubApiManager())
    @State private var activeSheet: Sheet?
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                SearchBar(searchText: $model.searchText)
                    .padding()
                    .background(Color.Misc.navigationBar)
                Divider()
                    .background(.ultraThinMaterial)
                switch model.state {
                case .loading:
                    Spacer()
                    LoadingView()
                    Spacer()
                case let .showingData(repositories):
                    if repositories.isEmpty {
                        Spacer()
                        Text("list.placeholder.description")
                            .font(.avenir(size: 18.0))
                            .foregroundStyle(Color.Text.primary)
                        Button(
                            action: onRefreshAction,
                            label: {
                                Text("list.placeholder.refresh")
                                    .font(.avenir(size: 16.0))
                            }
                        )
                        Spacer()
                    } else {
                        ScrollView() {
                            VStack(spacing: 0.0) {
                                ForEach(repositories) { repository in
                                    RepoListRow(
                                        name: repository.name,
                                        organizationName: repository.organizationName,
                                        description: repository.description,
                                        language: repository.language,
                                        starCount: repository.starCount,
                                        onTap: { showRepositoryDetailsView(repositoryID: repository.id) }
                                    )
                                    Divider()
                                }
                            }
                        }
                        .refreshable {
                            onRefreshAction()
                        }
                    }
                }
            }
            .background(Color.Background.main)
            .navigationTitle("list.navigation.title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: onRefreshAction, label: { Image(systemName: "arrow.clockwise") })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: showFiltersView, label: { Image(systemName: "line.3.horizontal.decrease") })
                }
            }
            .toast(message: $model.errorMessage)
            .onAppear() {
                onRefreshAction()
            }
        }
        .sheet(item: $activeSheet) {
            switch $0 {
            case .filters:
                SettingsView() { model.onSortMethodChange() }
            case let .repositoryDetails(id):
                RepositoryDetailsView(repositoryID: id)
            }
        }
    }
    
    // MARK: - Actions
    
    private func onRefreshAction() {
        model.updateData()
    }
    
    private func showFiltersView() {
        activeSheet = .filters
    }
    
    private func showRepositoryDetailsView(repositoryID: Int) {
        activeSheet = .repositoryDetails(repositoryID: repositoryID)
    }
}

struct RepoListViewPreview: PreviewProvider {
    
    static var previews: some View {
        RepoListView()
    }
}
