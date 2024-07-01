import SwiftUI

@available(iOS 14.0, *)
struct ImageGalleryView: View {
    // Sample data: replace with your image data
    let images = ["magnifyingglass","moon.fill", "cloud","moon","magnifyingglass","moon.fill", "cloud","moon"]

    // Define the grid layout
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(images, id: \.self) { imageName in
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 80 )
                        .background(Color.red)
                        .cornerRadius(10)
                        
                       
                        .clipped()
                }
            }
            .padding()
        }
    }
}

@available(iOS 13.0, *)
struct ImageGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 14.0, *) {
            ImageGalleryView()
        } else {
            // Fallback on earlier versions
        }
    }
}
