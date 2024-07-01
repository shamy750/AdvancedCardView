//
//  File.swift
//
//
//  Created by Softsuave on 26/06/2024.
//

import SwiftUI

@available(iOS 15.0, *)

public struct CardView: View {
    @Binding var imageArray: [String]
    private var backgroundColor: Color
    private var frameWidth: CGFloat
    private var frameHeight: CGFloat
    private var shadow: CGFloat
    private var imageWidth: CGFloat
    private var imageHeight: CGFloat
    private var zoomIn: Bool
    @Binding var gridView: Bool
    var onTap: ((Int) -> Void)?
    
    private var columnNo: Int
    private var columns: [GridItem]
    private var numberOfRows: Int = 2
  
    @State private var selectedImage: String = ""
    
    public init(imageArray: Binding<[String]>, 
                backgroundColor: Color = .white,
                frameWidth: CGFloat = 150,
                frameHeight: CGFloat = 150,
                shadow: CGFloat = 5,
                imageWidth: CGFloat = 40,
                imageHeight: CGFloat = 40,
                gridView: Binding<Bool>,
                zoomIn: Bool = true,
                columnNo: Int = 2,
                onTap: ((Int) -> Void)? = nil
                ) {
        
        self._imageArray = imageArray
        self.backgroundColor = backgroundColor
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.shadow = shadow
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self._gridView = gridView
        self.columnNo = columnNo
        self.columns = Array(repeating: GridItem(.flexible()), count: columnNo)
        self.onTap = onTap
        self.zoomIn = zoomIn
    }
    
    @available(iOS 15.0, *)
    public var body: some View {
        ZStack  {
            VStack {
                if gridView {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(Array(imageArray.enumerated()), id: \.element) { index, image in
                                CardContent(image: image, selectedImage: $selectedImage)
                                    .onTapGesture {
                                        self.selectedImage = ""
                                        self.onTap?(index)
                                        print(index)
                                    }
                                    .gesture(
                                        LongPressGesture(minimumDuration: 1)
                                            .onEnded { _ in
                                                self.selectedImage = image
                                            }
                                    )
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                } else {
                    
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(Array(imageArray.enumerated()), id: \.element) { index, image in
                                    GeometryReader { geometry in
                                        CardContent(image: image, selectedImage: $selectedImage)
                                            .frame(height: frameHeight + 20)
                                            .padding()
                                            .scaleEffect(scaleFactor(geometry: geometry))
                                            .animation(.easeInOut, value: scaleFactor(geometry: geometry))
                                            .onTapGesture {
                                                self.selectedImage = ""
                                                self.onTap?(index)
                                                print(index)
                                            }
                                            .gesture(
                                                LongPressGesture(minimumDuration: 1)
                                                    .onEnded { _ in
                                                        self.selectedImage = image
                                                    }
                                            )
                                    }
                                    .frame(width: frameWidth, height: frameHeight)
                                }
                            }
                            Spacer()
                                .padding()
                            
                        }

                    
                    
                }
            }
            if !selectedImage.isEmpty && zoomIn {
                VStack(alignment: .center) {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(backgroundColor)
                            .frame(width: 350, height: 350)
                            .shadow(radius: shadow)
                            .padding()
                        
                        Image(systemName: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .animation(.bouncy)
                            .padding()
                    }
                }
            }
        }.onTapGesture {
            selectedImage = ""
        }
        
    }
    

    func getSegment(for row: Int) -> [Int] {
        let itemsPerRow = (imageArray.count + numberOfRows - 1) / numberOfRows
        let start = row * itemsPerRow
        let end = min(start + itemsPerRow, imageArray.count)
        return Array(start..<end)
    }
    
    private func scaleFactor(geometry: GeometryProxy) -> CGFloat {
          let midX = geometry.frame(in: .global).midX
          let screenWidth = UIScreen.main.bounds.width
          let distanceFromCenter = abs(screenWidth / 2 - midX)
          let scale = max(1.2 - (distanceFromCenter / (screenWidth/1.5)), 0.8)
          return scale
      }
}
