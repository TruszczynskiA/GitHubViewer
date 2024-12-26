// --------------------------------------------------
// RepoListModel.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Combine
import Foundation

final class RepoListModel: ObservableObject {
    
    struct RepositoryModel: Identifiable {
        let id: Int
        let name: String
        let organizationName: String
        let description: String?
        let language: String?
        let starsCount: String
    }
    
    enum State {
        case loading
        case showingData(repositories: [RepositoryModel])
    }
    
    // MARK: - View Model
    
    @Published private(set) var state: State = .loading
}
