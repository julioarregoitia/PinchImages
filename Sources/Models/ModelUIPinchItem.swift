//
//  ModelUIPinchItem.swift
//  PinchCore
//
//  Created by Julio Arregoitía Val on 10/12/2024.
//

import Foundation
import SwiftUI

public struct ModelUIPinch {
    let items: [ModelUIPinchItem]
    let startIndex: Int
    let colorBackground: Color
    let colorBannerSelected: Color
    let colorButtonClose: Color
    
    public init(items: [ModelUIPinchItem], startIndex: Int, colorBackground: Color, colorBannerSelected: Color, colorButtonClose: Color) {
        self.items = items
        self.startIndex = startIndex
        self.colorBackground = colorBackground
        self.colorBannerSelected = colorBannerSelected
        self.colorButtonClose = colorButtonClose
    }
}

public struct ModelUIPinchItem: Identifiable, Hashable, Sendable {
    
    public let id: String
    let urlDetail: URL
    public let urlSmall: URL
    
    public init(id: String, urlDetail: URL, urlSmall: URL) {
        self.id = id
        self.urlDetail = urlDetail
        self.urlSmall = urlSmall
    }
}
