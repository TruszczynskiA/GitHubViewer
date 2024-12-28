// --------------------------------------------------
// GitHubApiJsonDecoder.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation

final class GitHubApiJsonDecoder: JSONDecoder, @unchecked Sendable {
    
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
