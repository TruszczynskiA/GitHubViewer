// --------------------------------------------------
// RepoListView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

// TODO: Error Handling

struct RepoListView: View {
    
    @StateObject var model = RepoListModel()
    
    @State var searchText: String = ""
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
                            action: onRefreshButtonAction,
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
                                        starsCount: $0.starsCount
                                    )
                                    Divider()
                                }
                            }
                        }
                        .refreshable {
                        }
                    }
                }
            }
            .background(Color.Background.main)
            .navigationTitle("list.navigation.title")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .automatic, prompt: Text("list.search.placeholder"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: onRefreshButtonAction, label: { Image(systemName: "arrow.clockwise") })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: onFilterButtonAction, label: { Image(systemName: "line.3.horizontal.decrease") })
                }
            }
        }
        .sheet(isPresented: $isFilterSheetPresented) {
            FiltersView()
        }
    }
    
    // MARK: - Actions
    
    private func onRefreshButtonAction() {
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
