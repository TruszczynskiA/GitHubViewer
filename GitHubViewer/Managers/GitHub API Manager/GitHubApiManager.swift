// --------------------------------------------------
// GitHubApiManager.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation

final class GitHubApiManager {
    
    enum ManagerError: Error {
        case internalError(error: InternalError)
        case invalidResponseError(code: Int?)
        case requestError(error: URLError)
        case unknownError(error: Error)
    }
    
    enum InternalError: Error {
        case invalidBaseUrl
        case invalidPath
    }
    
    // MARK: - Constants
    
    private static let baseURL = "https://api.github.com"
    
    // MARK: - Properties
    
    private let caller: GitHubApiCallable
    private let baseURL: String
    private let jsonDecoder = GitHubApiJsonDecoder()
    
    // MARK: - Properties
    
    init(caller: GitHubApiCallable = GitHubApiCaller(), baseURL: String = baseURL) {
        self.caller = caller
        self.baseURL = baseURL
    }
    
    // MARK: - Actions
    
    func perform<Request: Requestable>(request: Request) async throws -> Request.ResponseType {
        do {
            let urlRequest = try makeUrlRequest(request: request)
            let result = try await caller.perform(urlRequest: urlRequest)
            let data = try handle(response: result)
            return try jsonDecoder.decode(request.responseType, from: data)
        } catch {
            throw map(error: error)
        }
    }
    
    // MARK: - Helpers
    
    private func makeUrlRequest(request: any Requestable) throws -> URLRequest {
        
        guard var components = URLComponents(string: baseURL), components.scheme != nil, components.host != nil else { throw InternalError.invalidBaseUrl }
        components.path = request.path
        
        guard !components.path.isEmpty, let url = components.url else { throw InternalError.invalidPath }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        return urlRequest
    }
    
    private func map(error: any Error) -> ManagerError {
        switch error {
        case let error as ManagerError:
            return error
        case let error as InternalError:
            return .internalError(error: error)
        case let error as URLError:
            return .requestError(error: error)
        default:
            return .unknownError(error: error)
        }
    }
    
    private func handle(response: ApiResponse) throws -> Data {
        guard response.code == 200 else { throw ManagerError.invalidResponseError(code: response.code) }
        return response.data
    }
}
