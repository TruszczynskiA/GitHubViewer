// --------------------------------------------------
// SearchBar.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    
    var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.Text.secondary)
                TextField("list.search.placeholder", text: $searchText)
                    .font(.avenir(size: 18.0))
                    .foregroundStyle(Color.Text.secondary)
                    .submitLabel(.done)
            }
            .padding(7.0)
            .background(Color.Background.main)
            .cornerRadius(10.0)
        
        
    }
}

struct SearchBarPreviews: PreviewProvider {
    
    @State static var searchText: String = ""
    
    static var previews: some View {
        SearchBar(searchText: $searchText)
    }
}
