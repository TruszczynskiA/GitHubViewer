// --------------------------------------------------
// GitHubApiManagerTests.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Testing
import Foundation
@testable import GitHubViewer

struct GitHubApiManagerTests {
    
    @Test("Valid response for OrganizationReposRequest request")
    func validOrganizationReposResponse() async throws {
        
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
        
        let response = try await manager.perform(request: request)
        #expect(response == expectedResponse)
    }
    
    @Test("Error from URLSession")
    func invalidResponse() async {
        
        let urlError = URLError(.badURL)
        
        let apiCaller = GitHubApiCallerMock()
        apiCaller.response = .error(error: urlError)
        
        let manager = GitHubApiManager(caller: apiCaller)
        let request = OrganizationReposRequest(orgName: "qwerty")
        
        do {
            _ = try await manager.perform(request: request)
            Issue.record("Test passed without error")
        } catch let error as GitHubApiManager.ManagerError {
            guard case let .requestError(error) = error else {
                Issue.record("Invalid error type")
                return
            }
            #expect(error == urlError)
        } catch {
            Issue.record("Invalid error type")
        }
    }

    @Test("Response to invalid base URL")
    func invalidBaseURL() async {
        
        let expectedError = GitHubApiManager.InternalError.invalidBaseUrl
        
        let apiCaller = GitHubApiCallerMock()
        apiCaller.response = .json(code: nil, string: "")
        
        let manager = GitHubApiManager(caller: apiCaller, baseURL: "Invalid URL")
        let request = OrganizationReposRequest(orgName: "")
        
        do {
            _ = try await manager.perform(request: request)
            Issue.record("Test passed without error")
        } catch let error as GitHubApiManager.ManagerError {
            guard case let .internalError(error) = error else {
                Issue.record("Invalid error type")
                return
            }
            #expect(error == expectedError)
        } catch {
            Issue.record("Invalid error type")
        }
    }
    
    @Test("Response to invalid request path")
    func invalidRequestPath() async {
        
        let expectedError = GitHubApiManager.InternalError.invalidPath
        
        let apiCaller = GitHubApiCallerMock()
        apiCaller.response = .json(code: nil, string: "")
        let manager = GitHubApiManager(caller: apiCaller)
        
        let request = InvalidRequest()
        
        do {
            _ = try await manager.perform(request: request)
            Issue.record("Test passed without error")
        } catch let error as GitHubApiManager.ManagerError {
            guard case let .internalError(error) = error else {
                Issue.record("Invalid error type")
                return
            }
            #expect(error == expectedError)
        } catch {
            Issue.record("Invalid error type")
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
        
        do {
            _ = try await manager.perform(request: request)
            Issue.record("Test passed without error")
        } catch let error as GitHubApiManager.ManagerError {
            guard case let .invalidResponseError(code) = error else {
                Issue.record("Invalid error type")
                return
            }
            #expect(code == expectedHttpCode)
        } catch {
            Issue.record("Invalid error type")
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
