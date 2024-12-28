// --------------------------------------------------
// GitHubApiCallable.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation

protocol GitHubApiCallable: AnyObject {
    func perform(urlRequest: URLRequest) async throws -> ApiResponse
}
