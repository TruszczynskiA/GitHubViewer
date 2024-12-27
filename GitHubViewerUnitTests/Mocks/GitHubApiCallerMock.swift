// --------------------------------------------------
// GitHubApiCallerMock.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation
@testable import GitHubViewer

final class GitHubApiCallerMock {
    
    enum ResponseType {
        case json(code: Int?, string: String)
        case error(error: URLError)
    }
    
    var response: ResponseType?
}

extension GitHubApiCallerMock: GitHubApiCallable {
    
    func perform(urlRequest: URLRequest) async throws -> ApiResponse {
        
        guard let response else { fatalError() }
        
        switch response {
        case let .json(code, string):
            return ApiResponse(code: code, data: string.data(using: .utf8)!)
        case let .error(error):
            throw error
        }
    }
}
