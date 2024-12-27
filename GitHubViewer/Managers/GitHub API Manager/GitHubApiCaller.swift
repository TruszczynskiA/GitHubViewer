// --------------------------------------------------
// GitHubApiCaller.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation

final class GitHubApiCaller {}

extension GitHubApiCaller: GitHubApiCallable {
    
    func perform(urlRequest: URLRequest) async throws -> ApiResponse {
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        let httpResponse = response as? HTTPURLResponse
        return ApiResponse(code: httpResponse?.statusCode, data: data)
    }
}
