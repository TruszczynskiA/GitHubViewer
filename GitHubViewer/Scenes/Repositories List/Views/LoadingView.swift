// --------------------------------------------------
// LoadingView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        HStack(spacing: 10.0) {
            AnimatedCircleView(delay: 0.2)
            AnimatedCircleView(delay: 0.4)
            AnimatedCircleView(delay: 0.6)
        }
    }
}

struct LoadingViewPreview: PreviewProvider {
    
    static var previews: some View {
        LoadingView()
            .previewLayout(.sizeThatFits)
    }
}
