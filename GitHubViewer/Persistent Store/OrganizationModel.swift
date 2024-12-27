// --------------------------------------------------
// OrganizationModel.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import RealmSwift

final class OrganizationModel: Object {
    @Persisted(primaryKey: true) var login: String
    @Persisted var name: String?
    @Persisted var isVisible: Bool
    @Persisted var repositories: List<RepositoryModel>
}
