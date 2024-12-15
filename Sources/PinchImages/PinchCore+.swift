//
//  PinchCore+.swift
//  Pinch
//
//  Created by Julio Arregoitía Val on 10/12/2024.
//

import Foundation

extension ModelUIPinchItem {
    
    public static let preview: [ModelUIPinchItem] = [.previewItem1, .previewItem2, .previewItem3, .previewItem4]
    
    private static let urls: [URL] = [.init(string: "https://dev-admin.recargahoy.com/media/file/customizedmedia/a7699c9e.2d068ded-free")!,
                                      .init(string: "https://dev-admin.recargahoy.com/media/file/customizedmedia/a7699c9e.e4eedf52-free")!,
                                      .init(string: "https://dev-admin.recargahoy.com/media/file/customizedmedia/a7699c9e.f12b62d1-free")!,
                                      .init(string: "https://dev-admin.recargahoy.com/media/file/customizedmedia/a7699c9e.9c6c5ef9-free")!]

    static let previewItem1: ModelUIPinchItem = .init(id: "1", urlDetail: urls[0], urlSmall: urls[0])
    static let previewItem2: ModelUIPinchItem = .init(id: "2", urlDetail: urls[1], urlSmall: urls[1])
    static let previewItem3: ModelUIPinchItem = .init(id: "3", urlDetail: urls[2], urlSmall: urls[2])
    static let previewItem4: ModelUIPinchItem = .init(id: "4", urlDetail: urls[3], urlSmall: urls[3])
    
    
    public static var previewPlus: [ModelUIPinchItem] {
        
        let items = (0...20).map { ModelUIPinchItem(id: $0.description, urlDetail: urls[$0 % urls.count], urlSmall: urls[$0 % urls.count]) }
        return items
    }


}
