// --------------------------------------------------
// ErrorHandler.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation

enum ErrorHandler {
    
    static func errorMessage(error: Error) -> String {
        switch error {
        case let error as GitHubApiManager.ManagerError:
            return message(error: error)
        default:
            return NSLocalizedString("error.default", comment: "")
        }
    }
    
    // MARK: - GitHubApiManager.ManagerError
    
    private static func message(error: GitHubApiManager.ManagerError) -> String {
        switch error {
        case let .internalError(error):
            return message(error: error)
        case let .invalidResponseError(code):
            return message(gitHubHttpCode: code)
        case .requestError:
            return NSLocalizedString("error.github.request", comment: "")
        case  .unknownError:
            return NSLocalizedString("error.github.unknown", comment: "")
        }
    }
    
    private static func message(error: GitHubApiManager.InternalError) -> String {
        switch error {
        case .invalidBaseUrl:
            return NSLocalizedString("error.github.internal.invalidBaseUrl", comment: "")
        case .invalidPath:
            return NSLocalizedString("error.github.internal.invalidPath", comment: "")
        }
    }
    
    private static func message(gitHubHttpCode: Int?) -> String {
        switch gitHubHttpCode {
        case 403:
            return NSLocalizedString("error.github.httpCode.403", comment: "")
        case 404:
            return NSLocalizedString("error.github.httpCode.404", comment: "")
        default:
            return NSLocalizedString("error.github.httpCode.default", comment: "")
        }
    }
}
