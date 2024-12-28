// --------------------------------------------------
// RepoListModel.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Combine
import Foundation
import RealmSwift

final class RepoListModel: ObservableObject {
    
    struct RepositoryViewModel: Identifiable {
        let id: Int
        let name: String
        let organizationName: String
        let description: String?
        let language: String?
        let starCount: String
    }
    
    enum State {
        case loading
        case showingData(repositories: [RepositoryViewModel])
    }
    
    // MARK: - View Model
    
    @Published var searchText = ""
    @Published var errorMessage: String?
    @Published private(set) var state: State = .loading
    
    // MARK: - Properties
    
    private let apiManager = GitHubApiManager()
    private let realm = try! Realm()
    private let dateFormatter = DateFormatter.iso8601
    
    private var repositories: [RepositoryViewModel] = []
    private var notificationsTokens: [NotificationToken] = []
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var organizationsModels = realm.objects(OrganizationModel.self)
    private lazy var repositoriesModels = realm.objects(RepositoryModel.self)
    
    // MARK: - Initialisers
    
    init() {
        setupCallbacks()
    }
    
    // MARK: - Setups
    
    private func setupCallbacks() {
        
        $searchText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.updatePresentedData(searchText: $0) }
            .store(in: &cancellables)
        
        let repositoriesToken = repositoriesModels
            .observe { [weak self] _ in
                guard let self else { return }
                self.updatePresentedData(searchText: self.searchText)
            }
        
        let organizationsToken = organizationsModels
            .observe { [weak self] _ in
                guard let self else { return }
                self.updatePresentedData(searchText: self.searchText)
            }
        
        notificationsTokens = [repositoriesToken, organizationsToken]
    }
    
    // MARK: - Updates
    
    func updateData() {
        
        state = .loading
        
        Task { @MainActor in
            do {
                let organizations = realm.objects(OrganizationModel.self).map(\.login)
                let responses = try await Array(organizations).asyncMap { try await fetchData(organization: $0) }
                let organizationsModels = responses.map { makeOrganizationModel(organization: $0.organization, repositories: $0.repositories) }
                try realm.write {
                    realm.delete(realm.objects(OrganizationModel.self))
                    realm.delete(realm.objects(RepositoryModel.self))
                    realm.upsert(organizationsModels)
                }
            } catch {
                errorMessage = ErrorHandler.errorMessage(error: error)
            }
            
            state = .showingData(repositories: repositories)
        }
    }
    
    // MARK: - Helpers
    
    private func updatePresentedData(searchText: String) {
        
        let repositoriesModels: Results<RepositoryModel>
        
        if searchText.isEmpty {
            repositoriesModels = self.repositoriesModels
        } else {
            repositoriesModels = self.repositoriesModels.where {
                $0.name.contains(searchText, options: .caseInsensitive) || $0.note.contains(searchText, options: .caseInsensitive) || $0.organization.name.contains(searchText, options: .caseInsensitive)
            }
        }
        
        let viewModels = repositoriesModels
            .where { $0.organization.isVisible == true }
            .sorted(byKeyPath: "name")
            .map {
                RepositoryViewModel(
                    id: $0.id,
                    name: $0.name,
                    organizationName: $0.organization.first?.name ?? NSLocalizedString("common.unknown", comment: ""),
                    description: $0.note,
                    language: $0.language,
                    starCount: "\($0.starCount)")
            }
        
        repositories = Array(viewModels)
        
        switch state {
        case .showingData:
            state = .showingData(repositories: repositories)
        default:
            break
        }
    }
    
    // MARK: - API Actions
    
    private func fetchData(organization: String) async throws -> (organization: OrganizationResponse, repositories: [OrganizationReposResponse]) {
        let organizationData = try await fetchOrganizationData(organization: organization)
        let repositoriesData = try await fetchRepositories(organization: organization)
        return (organizationData, repositoriesData)
    }
    
    private func fetchOrganizationData(organization: String) async throws -> OrganizationResponse {
        let request = OrganizationRequest(orgName: organization)
        return try await apiManager.perform(request: request)
    }
    
    private func fetchRepositories(organization: String) async throws -> [OrganizationReposResponse] {
        let request = OrganizationReposRequest(orgName: organization)
        return try await apiManager.perform(request: request)
    }
    
    // MARK: - Helpers
    
    private func makeOrganizationModel(organization: OrganizationResponse, repositories: [OrganizationReposResponse]) -> OrganizationModel {
        
        let repositoriesModels = repositories.map {
            let model = RepositoryModel()
            model.id = $0.id
            model.name = $0.name
            model.note = $0.description
            model.language = $0.language
            model.starCount = $0.stargazersCount
            model.url = $0.htmlUrl
            model.homepage = $0.homepage
            model.createdAt = dateFormatter.date(from: $0.createdAt)
            model.updatedAt = dateFormatter.date(from: $0.updatedAt)
            model.pushedAt = dateFormatter.date(from: $0.pushedAt)
            model.size = $0.size
            model.forksCount = $0.forks
            model.openIssuesCount = $0.openIssues
            return model
        }
        
        let existingOrganization = realm.objects(OrganizationModel.self).first { $0.login == organization.login }
        
        let organizationModel = OrganizationModel()
        organizationModel.login = organization.login
        organizationModel.name = organization.name
        organizationModel.isVisible = existingOrganization?.isVisible ?? true
        organizationModel.repositories.append(objectsIn: repositoriesModels)
        
        return organizationModel
    }
}
