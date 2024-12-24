// --------------------------------------------------
// GitHubApiCallable.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation
import Combine

protocol GitHubApiCallable: AnyObject {
    func perform(urlRequest: URLRequest) -> AnyPublisher<ApiResponse, URLError>
}
