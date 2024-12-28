// --------------------------------------------------
// RepoListView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct RepoListView: View {
    
    @StateObject var model = RepoListModel()
    
    @State private var isFilterSheetPresented = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
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
                                ForEach(repositories) {
                                    RepoListRow(
                                        name: $0.name,
                                        organizationName: $0.organizationName,
                                        description: $0.description,
                                        language: $0.language,
                                        starCount: $0.starCount
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
            .searchable(text: $model.searchText, placement: .automatic, prompt: Text("list.search.placeholder"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: onRefreshAction, label: { Image(systemName: "arrow.clockwise") })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: onFilterButtonAction, label: { Image(systemName: "line.3.horizontal.decrease") })
                }
            }
            .toast(message: $model.errorMessage)
            .onAppear() {
                onRefreshAction()
            }
        }
        .sheet(isPresented: $isFilterSheetPresented) {
            FiltersView()
        }
    }
    
    // MARK: - Actions
    
    private func onRefreshAction() {
        model.updateData()
    }
    
    private func onFilterButtonAction() {
        isFilterSheetPresented.toggle()
    }
}

struct RepoListViewPreview: PreviewProvider {
    
    static var previews: some View {
        RepoListView()
    }
}
