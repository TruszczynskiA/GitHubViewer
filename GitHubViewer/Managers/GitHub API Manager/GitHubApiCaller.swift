// --------------------------------------------------
// GitHubApiCaller.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation
import Combine

final class GitHubApiCaller {}

extension GitHubApiCaller: GitHubApiCallable {
    
    func perform(urlRequest: URLRequest) -> AnyPublisher<ApiResponse, URLError> {
        URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map { ApiResponse(code: ($1 as? HTTPURLResponse)?.statusCode, data: $0) }
            .eraseToAnyPublisher()
    }
}
