// --------------------------------------------------
// RepositoryModel.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import RealmSwift

final class RepositoryModel: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var note: String?
    @Persisted var language: String?
    @Persisted var starCount: Int
    @Persisted(originProperty: "repositories") var organization: LinkingObjects<OrganizationModel>
}
