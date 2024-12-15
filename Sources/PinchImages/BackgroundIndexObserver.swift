//
//  BackgroundIndexObserver.swift
//  PinchCore
//
//  Created by Julio Arregoitía Val on 10/12/2024.
//

import SwiftUI

@available(iOS 17.0, macOS 10.15, tvOS 13.0, *)
struct BackgroundIndexObserver: View {
    
    @Binding var currentIndex: Int
    
    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            if let scrollViewWidth = proxy.bounds(of: .scrollView(axis: .horizontal))?.width,
               scrollViewWidth > 0
            {
                let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
                let totalPages = Int(width / scrollViewWidth)
                
                /// Progress
                let freeProgress = -minX / scrollViewWidth
                let clippedProgress = min(max(freeProgress, 0.0), CGFloat(totalPages - 1))
                let progress = clippedProgress
                
                let nextIndex = Int(progress.rounded(.awayFromZero))
                
                Color.clear
                    .preference(key: PreferenceKey.self, value: nextIndex)
                
            } else {
                Color.clear
            }
        }
        .onPreferenceChange(PreferenceKey.self) { index in
            Task { @MainActor in
                self.currentIndex = index
            }
        }
    }
    
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: Int { 0 }
        
        static func reduce(value: inout Int, nextValue: () -> Int) {
            // No-op
        }
    }
}
