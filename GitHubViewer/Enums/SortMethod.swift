// --------------------------------------------------
// SortMethod.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation

enum SortMethod: Int, Codable, CaseIterable {
    case name
    case stars
    case language
}

extension SortMethod {
    
    var title: String {
        switch self {
        case .name:
            return NSLocalizedString("filters.text.sorting.name", comment: "")
        case .stars:
            return NSLocalizedString("filters.text.sorting.stars", comment: "")
        case .language:
            return NSLocalizedString("filters.text.sorting.language", comment: "")
        }
    }
    
    var sortKey: String {
        switch self {
        case .name:
            return "name"
        case .stars:
            return "starCount"
        case .language:
            return "language"
        }
    }
    
    var isSortAscending: Bool { self != .stars }
}
