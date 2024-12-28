// --------------------------------------------------
// DateFormatter+CommonFormats.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation

extension DateFormatter {
    
    static var iso8601: Self {
        let formatter = Self()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }
    
    static var userInterfaceFormat: Self {
        let formatter = Self()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter
    }
}
