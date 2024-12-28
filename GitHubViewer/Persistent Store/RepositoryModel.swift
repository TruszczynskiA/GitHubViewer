// --------------------------------------------------
// RepositoryModel.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import RealmSwift
import Foundation

final class RepositoryModel: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var note: String?
    @Persisted var language: String?
    @Persisted var starCount: Int
    @Persisted var url: String
    @Persisted var createdAt: Date?
    @Persisted var updatedAt: Date?
    @Persisted var pushedAt: Date?
    @Persisted var homepage: String?
    @Persisted var size: Int
    @Persisted var forksCount: Int
    @Persisted var openIssuesCount: Int
    
    @Persisted(originProperty: "repositories") var organization: LinkingObjects<OrganizationModel>
}
