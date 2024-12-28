// --------------------------------------------------
// SettingsView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject private var model = SettingsModel()
    
    init(onSortingMethodChange: @escaping () -> Void) {
        model.onSortingMethodChange = onSortingMethodChange
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                    .background(.ultraThinMaterial)
                ScrollView {
                    Text("filters.text.title.visibleOrganizations")
                        .font(.avenir(size: 24.0))
                        .bold()
                        .foregroundStyle(Color.Text.primary)
                        .padding()
                    Divider()
                    ForEach(model.organizations) { viewModel in
                        OrganizationFilterRow(
                            id: viewModel.id,
                            name: viewModel.name,
                            reposCount: viewModel.reposCount,
                            isSelected: viewModel.isSelected,
                            onTap: { model.toggleVisibleOrganizationsSelection(id: viewModel.id) }
                        )
                        Divider()
                    }
                    Text("filters.text.title.sortBy")
                        .font(.avenir(size: 24.0))
                        .bold()
                        .foregroundStyle(Color.Text.primary)
                        .padding()
                    Divider()
                    ForEach(model.sortOptions) { viewModel in
                        SortMethodRow(title: viewModel.title, isSelected: viewModel.isSelected, onTap: { model.selectSortMethod(row: viewModel.id) })
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
    SettingsView(onSortingMethodChange: {})
}
