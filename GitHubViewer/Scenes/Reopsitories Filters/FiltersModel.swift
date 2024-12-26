// --------------------------------------------------
// FiltersModel.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Combine

final class FiltersModel: ObservableObject {
    
    struct OrganizationData: Identifiable {
        let id: Int
        let name: String
        let reposCount: Int
        var isSelected: Bool
    }
    
    // MARK: - View Model
    
    @Published private(set) var organizations: [OrganizationData] = [ // TODO: Remove Data
        OrganizationData(id: 1, name: "Name 1", reposCount: 123, isSelected: true),
        OrganizationData(id: 2, name: "Name 2", reposCount: 1, isSelected: false),
        OrganizationData(id: 3, name: "Name 3", reposCount: 12, isSelected: true)
    ]
    
    // MARK: - Actions
    
    func toggleSelection(id: Int) {
        guard let index = organizations.firstIndex(where: { $0.id == id }) else { return }
        organizations[index].isSelected.toggle()
    }
}
