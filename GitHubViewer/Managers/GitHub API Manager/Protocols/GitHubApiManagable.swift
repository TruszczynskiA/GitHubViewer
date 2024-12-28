// --------------------------------------------------
// GitHubApiManagable.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

protocol GitHubApiManagable {
    func perform<Request: Requestable>(request: Request) async throws -> Request.ResponseType
}
