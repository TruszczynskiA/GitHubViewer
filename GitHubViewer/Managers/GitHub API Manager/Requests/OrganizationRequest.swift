// --------------------------------------------------
// OrganizationRequest.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

struct OrganizationRequest {
    let orgName: String
}

extension OrganizationRequest: Requestable {
    typealias ResponseType = OrganizationResponse
    var path: String { "/orgs/\(orgName)" }
    var method: RequestMethod { .get }
}

struct OrganizationResponse: Decodable, Identifiable {
    let id: Int
    let login: String
    let name: String
}
