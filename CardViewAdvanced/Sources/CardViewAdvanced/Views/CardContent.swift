//
//  File.swift
//
//
//  Created by Softsuave on 28/06/2024.
//

import SwiftUI

@available(iOS 13.0, *)
struct CardContent: View {
    
    private var backgroundColor: Color
    private var frameWidth: CGFloat
    private var frameHeight: CGFloat
    private var shadowRadius: CGFloat
    private var imageWidth: CGFloat
    private var imageHeight: CGFloat
    private var image: String
    @Binding var selectedImage: String
    
    
    
    init(backgroundColor: Color = .white,
         frameWidth:CGFloat = 150,
         frameHeight:CGFloat = 150,
         imageWidth: CGFloat = 40,
         shadowRadius: CGFloat = 5,
         imageHeight:CGFloat = 40 ,
         image: String ,
         selectedImage: Binding<String>
         
    ) {
        self.backgroundColor = backgroundColor
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.shadowRadius = shadowRadius
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.image = image
        self._selectedImage = selectedImage
        
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(backgroundColor)
                .frame(width: frameWidth, height: frameHeight)
                .shadow(radius: shadowRadius)
            
            Image(systemName: image)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: imageWidth, height: imageHeight)
                .padding()
        }
    }
}
