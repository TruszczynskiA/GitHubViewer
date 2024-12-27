// --------------------------------------------------
// AppConfigurator.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import RealmSwift

enum AppConfigurator {
    
    static func configure() {
        
        guard AppUserDefaults.dataInitialised != true else { return }
        
        let organizations = ["perawallet", "algorandfoundation", "algorand"]
            .map {
                let model = OrganizationModel()
                model.login = $0
                model.isVisible = true
                return model
            }
        
        let realm = try? Realm()
        
        try? realm?.write {
            realm?.upsert(organizations)
        }
        
        AppUserDefaults.dataInitialised = true
    }
}
