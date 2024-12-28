// --------------------------------------------------
// FiltersModel.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Combine
import RealmSwift

final class FiltersModel: ObservableObject {
    
    struct OrganizationData: Identifiable {
        let id: String
        let name: String
        let reposCount: Int
        let isSelected: Bool
    }
    
    // MARK: - View Model
    
    @Published private(set) var organizations: [OrganizationData] = []
    
    // MARK: - Properties
    
    private let realm = try! Realm()
    private lazy var organizationsModels = realm.objects(OrganizationModel.self)
    private var organizationsModelsToken: NotificationToken?
    
    // MARK: - Initialisers
    
    init() {
        setupCallbacks()
    }
    
    // MARK: - Setups
    
    private func setupCallbacks() {
        
        organizationsModelsToken = organizationsModels.observe { [weak self]_ in
            self?.updateData()
        }
    }
    
    // MARK: - Updates
    
    private func updateData() {
        organizations = organizationsModels.map { OrganizationData(id: $0.login, name: $0.name ?? $0.login, reposCount: $0.repositories.count, isSelected: $0.isVisible) }
    }
    
    // MARK: - Actions
    
    func toggleSelection(id: String) {
        
        guard let model = organizationsModels.first(where: { $0.login == id }) else { return }
        
        try? realm.write {
            model.isVisible.toggle()
        }
    }
}
