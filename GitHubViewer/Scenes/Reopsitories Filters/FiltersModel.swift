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
    
    @Published private(set) var organizations: [OrganizationData] = []
    
    // MARK: - Actions
    
    func toggleSelection(id: Int) {
        guard let index = organizations.firstIndex(where: { $0.id == id }) else { return }
        organizations[index].isSelected.toggle()
    }
}
