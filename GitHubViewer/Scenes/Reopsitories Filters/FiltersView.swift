// --------------------------------------------------
// FiltersView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct FiltersView: View {
    
    @StateObject private var model = FiltersModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                    .background(.ultraThinMaterial)
                ScrollView {
                    ForEach(model.organizations) { viewModel in
                        OrganizationFilterRow(
                            id: viewModel.id,
                            name: viewModel.name,
                            reposCount: viewModel.reposCount,
                            isSelected: viewModel.isSelected,
                            onTap: { model.toggleSelection(id: viewModel.id) }
                        )
                        Divider()
                    }
                }
            }
            .background(Color.Background.main)
            .navigationTitle("filters.navigation.title")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FiltersView()
}
