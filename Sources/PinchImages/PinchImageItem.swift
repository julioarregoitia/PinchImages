//
//  PinchImageItem.swift
//  PinchCore
//
//  Created by Julio Arregoitía Val on 12/14/24.
//

import SwiftUI

@available(iOS 17.0, macOS 10.15, tvOS 13.0, *)
public struct PinchImageItem: View {
    
    let isSelected: Bool
    let image: Image
    let size: CGSize

    public init(isSelected: Bool, image: Image, size: CGSize, imageScaleParents: Binding<CGFloat>) {
        self.isSelected = isSelected
        self.image = image
        self.size = size
        self._imageScaleParents = imageScaleParents
    }
    
    @Binding var imageScaleParents: CGFloat
    
    @State private var imageScale: CGFloat = 1
    @State private var currentScale: CGFloat = 1
    @State private var finalScale: CGFloat = 1

    
    @State private var imageOffset: CGSize = .zero
    @State private var currentOffset: CGSize = .zero
    @State private var finalOffset: CGSize = .zero
    
    
    public var body: some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: size.width, height: size.height)
            .scaleEffect(imageScale)
            .offset(imageOffset)
            .onTapGesture(count: 2) {
                if imageScale == 1 {
                    withAnimation(.spring) {
                        imageScale = 5
                    }
                } else {
                    resetImageImageState()
                }
            }
            .gesture(DragGesture()
                .onChanged{ value in
                    
                    guard imageScale > 1 else { return }
                    
                    currentOffset = value.translation
                    
                    let newValue = CGSize(width: finalOffset.width + value.translation.width,
                                          height: finalOffset.height + value.translation.height)
                    withAnimation(.linear) {
                        
                        imageOffset = newValue
                    }
                }
                .onEnded { _ in
                    if imageScale <= 1 {
                        resetImageImageState()
                    }
                    let currentFinal = self.finalOffset
                    let newFinal = CGSize(width: currentFinal.width + currentOffset.width,
                                          height: currentFinal.height + currentOffset.height)
                    self.finalOffset = newFinal
                    self.currentOffset = .zero
                }, isEnabled: imageScale > 1)
            .gesture(MagnificationGesture()
                .onChanged { value in

                    self.currentScale = value
                    let newValue = finalScale * value
                    
                    withAnimation(.linear) {
                        if imageScale >= 1 && imageScale <= 5 {
                            imageScale = newValue
                            
                        } else if imageScale > 5 {
                            imageScale = 5
                        }
                    }
                }
                .onEnded { _ in
                    if imageScale > 5 {
                        imageScale = 5
                        
                    } else if imageScale <= 1 {
                        resetImageImageState()
                    } else {
                        let currentFinal = self.finalScale
                        let newFinal = currentFinal * self.currentScale
                        
                        self.finalScale = newFinal
                        self.currentScale = 1
                    }
                }
            )
            .onDisappear {
                resetImageImageState()
            }
            .onChange(of: isSelected) { _, newValue in
                self.resetImageImageState()
            }
            .onChange(of: imageScale) { _, newValue in
                self.imageScaleParents = newValue
            }
    }
    
    private func resetImageImageState() {
        return withAnimation(.spring) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
}
