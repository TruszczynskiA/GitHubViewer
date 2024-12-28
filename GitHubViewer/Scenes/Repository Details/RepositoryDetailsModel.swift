// --------------------------------------------------
// RepositoryDetailsModel.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Combine
import RealmSwift
import Foundation

final class RepositoryDetailsModel: ObservableObject {
    
    struct DateViewModel: Identifiable {
        let id = UUID()
        let title: String
        let formattedDate: String
    }
    
    struct RepositoryViewModel {
        let name: String
        let description: String?
        let language: String?
        let size: String
        let dates: [DateViewModel]
        let starCount: String
        let forksCount: String
        let openIssuesCount: String
        let githubPage: URL?
        let homepage: URL?
    }
    
    // MARK: - View Model
    
    @Published private(set) var repository: RepositoryViewModel?
    
    // MARK: - Properties
    
    var repositoryID: Int? {
        didSet { fetchModel() }
    }
    
    private let realm = try! Realm()
    private let dateFormatter = DateFormatter.userInterfaceFormat
    
    // MARK: - Actions
    
    private func fetchModel() {
        guard let repositoryID else { return }
        repository = realm.objects(RepositoryModel.self)
            .where { $0.id == repositoryID }
            .first
            .map { map(repositoryModel: $0) }
    }
    
    private func map(repositoryModel: RepositoryModel) -> RepositoryViewModel {
        
        var dates: [DateViewModel] = []
        
        if let createdAt = repositoryModel.createdAt {
            dates.append(DateViewModel(title: NSLocalizedString("repositoryDetails.text.createdAt",comment: ""), formattedDate: dateFormatter.string(from: createdAt)))
        }
        
        if let updatedAt = repositoryModel.updatedAt {
            dates.append(DateViewModel(title: NSLocalizedString("repositoryDetails.text.updatedAt",comment: ""), formattedDate: dateFormatter.string(from: updatedAt)))
        }
        
        if let pushedAt = repositoryModel.pushedAt {
            dates.append(DateViewModel(title: NSLocalizedString("repositoryDetails.text.pushedAt",comment: ""), formattedDate: dateFormatter.string(from: pushedAt)))
        }
        
        let githubPage = URL(string: repositoryModel.url)
        var homepage: URL?
        
        if let rawHomepage = repositoryModel.homepage {
            homepage = URL(string: rawHomepage)
        }
        
        return RepositoryViewModel(
            name: repositoryModel.name,
            description: repositoryModel.note,
            language: repositoryModel.language,
            size: "\(repositoryModel.size) kB",
            dates: dates,
            starCount: "\(repositoryModel.starCount)",
            forksCount: "\(repositoryModel.forksCount)",
            openIssuesCount: "\(repositoryModel.openIssuesCount)",
            githubPage: githubPage,
            homepage: homepage
        )
    }
}
