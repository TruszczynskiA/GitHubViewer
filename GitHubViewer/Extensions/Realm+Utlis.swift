// --------------------------------------------------
// Realm+Utlis.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import RealmSwift

extension Realm {
    
    func upsert(_ object: Object) {
        add(object, update: .all)
    }
    
    func upsert(_ objects: [Object]) {
        add(objects, update: .all)
    }
}
