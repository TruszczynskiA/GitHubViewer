// --------------------------------------------------
// UserDefault.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import Foundation

@propertyWrapper struct UserDefault<T: Codable> {

    private let key: String
    private let userDefaults: UserDefaults

    init(key: String, suiteName: String? = nil) {
        self.key = key
        userDefaults = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
    }

    var wrappedValue: T? {
        get {
            guard let encodedData = UserDefaults.standard.data(forKey: key) else { return nil }
            return try? JSONDecoder().decode(T.self, from: encodedData)
        }
        set {
            guard let encodedValue = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(encodedValue, forKey: key)
        }
    }
}
