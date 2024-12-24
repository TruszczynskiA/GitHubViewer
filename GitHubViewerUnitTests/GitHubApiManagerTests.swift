// --------------------------------------------------
// GitHubApiManagerTests.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Testing
import Combine
import Foundation
@testable import GitHubViewer

struct GitHubApiManagerTests {
    
    @Test("Valid response for OrganizationReposRequest request")
    func validOrganizationReposResponse() async {
        
        let rawResponse = """
        [
            {
                "id": 1,
                "name": "Foo",
                "stargazers_count": 123
            },
            {
                "id": 2,
                "name": "Bar",
                "description": "I'm Bar",
                "stargazers_count": 321,
                "language": "Swift"
            }
        ]
        """
        
        let expectedResponse = [
            OrganizationReposResponse(id: 1, name: "Foo", description: nil, stargazersCount: 123, language: nil),
            OrganizationReposResponse(id: 2, name: "Bar", description: "I'm Bar", stargazersCount: 321, language: "Swift")
        ]
        
        let apiCaller = GitHubApiCallerMock()
        apiCaller.response = .json(code: 200, string: rawResponse)
        let manager = GitHubApiManager(caller: apiCaller)
        
        let request = OrganizationReposRequest(orgName: "qwerty")
        
        var cancellables = Set<AnyCancellable>()
        
        await confirmation { confirmation in
            manager.perform(request: request)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { response in
                        #expect(response == expectedResponse)
                        confirmation()
                    }
                )
                .store(in: &cancellables)
        }
    }
    
    @Test("Error from URLSession")
    func invalidResponse() async {
        
        let urlError = URLError(.badURL)
        
        let apiCaller = GitHubApiCallerMock()
        apiCaller.response = .error(error: urlError)
        let manager = GitHubApiManager(caller: apiCaller)
        
        let request = OrganizationReposRequest(orgName: "qwerty")
        
        var cancellables = Set<AnyCancellable>()
        
        await confirmation { confirmation in
            manager.perform(request: request)
                .sink(
                    receiveCompletion: { completion in
                        
                        guard case let .failure(error) = completion else {
                            Issue.record("Test passed without error")
                            return
                        }
                        
                        guard case let .requestError(error) = error else {
                            Issue.record("Invalid error type")
                            return
                        }
                        
                        #expect(error == urlError)
                        confirmation()
                    },
                    receiveValue: { _ in }
                )
                .store(in: &cancellables)
        }
    }

    @Test("Response to invalid base URL")
    func invalidBaseURL() async {
        
        let expectedError = GitHubApiManager.InternalError.invalidBaseUrl
        
        let apiCaller = GitHubApiCallerMock()
        apiCaller.response = .json(code: nil, string: "")
        let manager = GitHubApiManager(caller: apiCaller, baseURL: "Invalid URL")
        
        let request = OrganizationReposRequest(orgName: "")
        
        var cancellables = Set<AnyCancellable>()
        
        await confirmation { confirmation in
            manager.perform(request: request)
                .sink(
                    receiveCompletion: { completion in
                        guard case let .failure(error) = completion else {
                            Issue.record("Test passed without error")
                            return
                        }
                        
                        guard case let .internalError(error) = error else {
                            Issue.record("Invalid error type")
                            return
                        }
                        
                        #expect(error == expectedError)
                        confirmation()
                    },
                    receiveValue: { _ in }
                )
                .store(in: &cancellables)
        }
    }
    
    @Test("Response to invalid request path")
    func invalidRequestPath() async {
        
        let expectedError = GitHubApiManager.InternalError.invalidPath
        
        let apiCaller = GitHubApiCallerMock()
        apiCaller.response = .json(code: nil, string: "")
        let manager = GitHubApiManager(caller: apiCaller)
        
        let request = InvalidRequest()
        
        var cancellables = Set<AnyCancellable>()
        
        await confirmation { confirmation in
            manager.perform(request: request)
                .sink(
                    receiveCompletion: { completion in
                        guard case let .failure(error) = completion else {
                            Issue.record("Test passed without error")
                            return
                        }
                        
                        guard case let .internalError(error) = error else {
                            Issue.record("Invalid error type")
                            return
                        }
                        
                        #expect(error == expectedError)
                        confirmation()
                    },
                    receiveValue: { _ in }
                )
                .store(in: &cancellables)
        }
    }
    
    @Test("Response with invalid HTTP code")
    func invalidHttpCode() async {
        
        let expectedHttpCode = 404
        
        let rawResponse = """
        [
            {
                "id": 1,
                "name": "Foo",
                "stargazers_count": 123
            },
            {
                "id": 2,
                "name": "Bar",
                "description": "I'm Bar",
                "stargazers_count": 321,
                "language": "Swift"
            }
        ]
        """
        
        let apiCaller = GitHubApiCallerMock()
        apiCaller.response = .json(code: expectedHttpCode, string: rawResponse)
        let manager = GitHubApiManager(caller: apiCaller)
        
        let request = OrganizationReposRequest(orgName: "qwerty")
        
        var cancellables = Set<AnyCancellable>()
        
        await confirmation { confirmation in
            manager.perform(request: request)
                .sink(
                    receiveCompletion: { completion in
                        guard case let .failure(error) = completion else {
                            Issue.record("Test passed without error")
                            return
                        }
                        
                        guard case let .invalidResponseError(code) = error else {
                            Issue.record("Invalid error type")
                            return
                        }
                        
                        #expect(code == expectedHttpCode)
                        confirmation()
                    },
                    receiveValue: { _ in }
                )
                .store(in: &cancellables)
        }
    }
}

// MARK: - Data types

private struct InvalidRequest {}

extension InvalidRequest: Requestable {
    typealias ResponseType = EmptyResponse
    var path: String { "" }
    var method: RequestMethod { .get }
}

private struct EmptyResponse: Decodable {}
