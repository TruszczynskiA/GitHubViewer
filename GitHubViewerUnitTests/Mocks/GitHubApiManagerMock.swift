// --------------------------------------------------
// GitHubApiManagerMock.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

@testable import GitHubViewer

final class GitHubApiManagerMock {
    var requestCallback: ((any Requestable) -> Decodable)?
}

extension GitHubApiManagerMock: GitHubApiManagable {
    
    func perform<Request: Requestable>(request: Request) async throws -> Request.ResponseType {
        return requestCallback!(request) as! Request.ResponseType
    }
}
