// --------------------------------------------------
// SettingsModel.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Combine
import RealmSwift

final class SettingsModel: ObservableObject {
    
    struct OrganizationData: Identifiable {
        let id: String
        let name: String
        let reposCount: Int
        let isSelected: Bool
    }
    
    struct SortMethodData: Identifiable {
        let id: Int
        let title: String
        let isSelected: Bool
    }
    
    // MARK: - View Model
    
    @Published private(set) var organizations: [OrganizationData] = []
    @Published private(set) var sortOptions: [SortMethodData] = []
    
    // MARK: - Properties
    
    var onSortingMethodChange: (() -> Void)?
    
    private let realm = try! Realm()
    private lazy var organizationsModels = realm.objects(OrganizationModel.self)
    private var organizationsModelsToken: NotificationToken?
    
    // MARK: - Initialisers
    
    init() {
        setupCallbacks()
        updateSortOptionsData()
    }
    
    // MARK: - Setups
    
    private func setupCallbacks() {
        
        organizationsModelsToken = organizationsModels.observe { [weak self]_ in
            self?.updateOrganizationsData()
        }
    }
    
    // MARK: - Updates
    
    private func updateOrganizationsData() {
        organizations = organizationsModels.map { OrganizationData(id: $0.login, name: $0.name ?? $0.login, reposCount: $0.repositories.count, isSelected: $0.isVisible) }
    }
    
    private func updateSortOptionsData() {
        let selectedOption = AppUserDefaults.sortMethod ?? .name
        sortOptions = SortMethod.allCases.map { SortMethodData(id: $0.rawValue, title: $0.title, isSelected: $0 == selectedOption) }
    }
    
    // MARK: - Actions
    
    func toggleVisibleOrganizationsSelection(id: String) {
        
        guard let model = organizationsModels.first(where: { $0.login == id }) else { return }
        
        try? realm.write {
            model.isVisible.toggle()
        }
    }
    
    func selectSortMethod(row: Int) {
        guard let method = SortMethod(rawValue: row) else { return }
        AppUserDefaults.sortMethod = method
        updateSortOptionsData()
        onSortingMethodChange?()
    }
}
