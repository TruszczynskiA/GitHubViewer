// --------------------------------------------------
// OrganizationReposRequest.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

struct OrganizationReposRequest {
    let orgName: String
}

extension OrganizationReposRequest: Requestable {
    typealias ResponseType = [OrganizationReposResponse]
    var path: String { "/orgs/\(orgName)/repos" }
    var method: RequestMethod { .get }
}

struct OrganizationReposResponse: Decodable, Equatable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let language: String?
}
