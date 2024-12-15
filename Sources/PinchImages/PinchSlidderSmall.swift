//
//  PinchSlidderSmall.swift
//  Pinch
//
//  Created by Julio Arregoitía Val on 10/12/2024.
//

import SwiftUI

@available(iOS 17.0, macOS 10.15, tvOS 13.0, *)
struct PinchSlidderSmall: View {
    
    let items: [ModelUIPinchItem]
    let colorBannerSelected: Color
    @Binding var selectedParent: String?
    
    @State var selectedLocal: String?
    
    var body: some View {
        
            ScrollView(.horizontal) {
                scrollContent
                    .scrollTargetLayout()

            } //: SCROLL VIEW
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $selectedLocal, anchor: .center)
            .scrollIndicators(.never)
            .safeAreaPadding(.horizontal, 10)
            .frame(height: 60, alignment: .center)
        
    }
    
    var scrollContent: some View {
        
        LazyHStack(spacing: 2) {
                        
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                PinchSlidderSmallItem(item: item, isSelected: selectedParent == item.id, colorBannerSelected: colorBannerSelected, selectedParent: $selectedParent, selectedLocal: $selectedLocal)
                    .id(item.id)
            }
            .onChange(of: selectedParent) { oldValue, newValue in
                if let newValue {
                    withAnimation {
                        self.selectedLocal = newValue
                    }
                }
            }
            
        } //: HSTACK
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

fileprivate struct PinchSlidderSmallItem: View {
    
    let item: ModelUIPinchItem
    let isSelected: Bool
    let colorBannerSelected: Color
    @Binding var selectedParent: String?
    @Binding var selectedLocal: String?

    
    var body: some View {
        AsyncImage(url: item.urlSmall) { image in
            image.resizable()
                .frame(width: 60, height: 60)
        } placeholder: {
            ProgressView().progressViewStyle(CircularProgressViewStyle())
        }
        .frame(width: 60, height: 60)
        .overlay(alignment: .bottom) {
            colorBannerSelected
                .frame(width: 60, height: 3)
                .opacity(isSelected ? 1 : 0)
        }
        .onTapGesture {
            withAnimation {
                selectedParent = item.id
            }
        }
    }
}

#Preview {
    ScrollViewReader { reader in
        if #available(iOS 17.0, *) {
            PinchSlidderSmall(items: ModelUIPinchItem.previewPlus,
                              colorBannerSelected: .blue,
                              selectedParent: .constant("0"))
        } 
    }
}
