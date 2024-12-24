// --------------------------------------------------
// GitHubApiCallerMock.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation
import Combine
@testable import GitHubViewer

final class GitHubApiCallerMock {
    
    enum ResponseType {
        case json(code: Int?, string: String)
        case error(error: URLError)
    }
    
    var response: ResponseType?
}

extension GitHubApiCallerMock: GitHubApiCallable {
    
    func perform(urlRequest: URLRequest) -> AnyPublisher<ApiResponse, URLError> {
        
        guard let response else { fatalError() }
        
        switch response {
        case let .json(code, string):
            return Just(ApiResponse(code: code, data: string.data(using: .utf8)!))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        case let .error(error):
            return Fail<ApiResponse, URLError>(error: error)
                .eraseToAnyPublisher()
        }
    }
}
