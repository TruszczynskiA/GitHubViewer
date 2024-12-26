// --------------------------------------------------
// AnimatedCircleView.swift
// Copyright © 2024 Adrian Truszczyński.
// All Rights Reserved.
// --------------------------------------------------

import SwiftUI

struct AnimatedCircleView: View {
    
    @State var delay: TimeInterval
    @State private var opacity: Double = 0.2
    
    var body: some View {
        Circle()
            .foregroundStyle(Color.Misc.primary)
            .frame(width: 10.0, height: 10.0)
            .opacity(opacity)
            .onAppear() {
                withAnimation(.linear(duration: 1.0).repeatForever().delay(delay)) {
                    opacity = 1.0
                }
            }
    }
}

struct AnimatedCircleViewPreview: PreviewProvider {
    
    static var previews: some View {
        AnimatedCircleView(delay: 0.0)
            .previewLayout(.sizeThatFits)
    }
}
