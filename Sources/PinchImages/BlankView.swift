//
//  BlankView.swift
//  PinchCore
//
//  Created by Julio Arregoitía Val on 10/12/2024.
//

import SwiftUI

public struct BlankView: View {
    
    let backgroundColor: Color
    let backgroundOpacity: Double
    
    public init(backgroundColor: Color, backgroundOpacity: Double) {
        self.backgroundColor = backgroundColor
        self.backgroundOpacity = backgroundOpacity
    }
    
    public var body: some View {
        VStack {
            backgroundColor
        }
        .frame(minWidth: 0, maxWidth: .infinity,
               minHeight: 0, maxHeight: .infinity)
        .opacity(backgroundOpacity)
        .blendMode(.overlay)
        .edgesIgnoringSafeArea(.all)
    }
}
