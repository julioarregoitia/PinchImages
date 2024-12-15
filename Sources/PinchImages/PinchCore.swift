// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI


@available(iOS 17.0, macOS 10.15, tvOS 13.0, *)
public struct PinchImageSlidder: View {
    
    let model: ModelUIPinch
    @Binding var isPresenting: Bool
    
    @State private var imageScale: CGFloat = 1

    
    public init(model: ModelUIPinch, isPresenting: Binding<Bool>) {
        self.model = model
        self._isPresenting = isPresenting
    }
    
    @State private var scrolledID: String? = nil
        
    public var body: some View {
        
        GeometryReader { proxy in
            
            ZStack {
                BlankView(backgroundColor: model.colorBackground, backgroundOpacity: 0.6)
                    .onTapGesture {
                        withAnimation {
                            self.isPresenting = false
                        }
                    }
                
                scrollContent(size: proxy.size)
                
                previewSmall
                    .opacity(imageScale == 1 ? 1 : 0)
                    .animation(.easeInOut, value: imageScale)
            }
        }
        .overlay(alignment: .topLeading) {
            Button {
                self.isPresenting = false
            } label: {
                Image(systemName: "xmark").renderingMode(.template)
                    .resizable()
                    .foregroundStyle(model.colorButtonClose)
                    .frame(width: 30, height: 30)
            }
            .padding(20)
            .opacity(imageScale == 1 ? 1 : 0)
            .animation(.easeInOut, value: imageScale)
        }
        .onAppear {
            guard model.startIndex < model.items.count else { return }
            let identifier = model.items[0].id
            self.scrolledID = identifier
        }
        
    } //: BODY
    
    var previewSmall: some View {
        VStack {
            Spacer()
            
            PinchSlidderSmall(items: model.items, colorBannerSelected: model.colorBannerSelected, selectedParent: $scrolledID)
        }
    }
    
    @ViewBuilder func scrollContent(size: CGSize) -> some View {
        
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                
                ForEach(model.items) { item in
                    
                    ViewItem(item: item,
                             size: size,
                             isSelected: scrolledID == item.id,
                             imageScaleParent: $imageScale)
                } //: FOR EACH
                
            } //: LAZY HSTACK
            .scrollTargetLayout()
            
        } //: SCROLL VIEW
        .scrollPosition(id: $scrolledID, anchor: .center)
        .scrollIndicators(.never)
        .scrollTargetBehavior(.paging)
    } //: SCROLL CONTENT
    
}

@available(iOS 17.0, *)
fileprivate struct ViewItem: View {
    
    let item: ModelUIPinchItem
    let size: CGSize
    let isSelected: Bool
    
    @Binding var imageScaleParent: CGFloat
    
    
    var body: some View {
        
        AsyncImage(url: item.urlDetail, transaction: .init(animation: .easeInOut)) { phase in
            switch phase {
            case .empty:
                ProgressView().progressViewStyle(CircularProgressViewStyle())
                    .frame(width: size.width)
                
            case .failure:
                Image(systemName: "photo.artframe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width, height: 100)
                    .transition(.move(edge: .bottom))
                
            case .success(let image):
                PinchImageItem(isSelected: isSelected, image: image, size: size, imageScaleParents: $imageScaleParent)
                
            @unknown default:
                Image(systemName: "photo.artframe")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width, height: 100)
                    .transition(.move(edge: .bottom))
            }
            
        } //: ASYNC IMAGE
        .id(item.id)
    }
}
