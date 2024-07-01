//
//  ContentView.swift
//  AdvancedCardView
//
//  Created by Softsuave on 26/06/2024.
//

import SwiftUI
import CardViewAdvanced

struct ContentView: View {
    
   @State private var imageArray: [String] = ["magnifyingglass","moon.fill","sun.min", "cloud","moon","sun.max","sun.snow", "sun.max.fill", "moon.zzz", "cloud.snow.fill", "cloud.snow", "sun.snow.fill", "cloud.fog"]
    @State private var toggle: Bool = false
    
    var body: some View {
        VStack {
            Toggle("Change View", isOn: $toggle)
                .padding()
            
            CardView(imageArray: $imageArray,gridView: $toggle) { indexNo in
                print(indexNo)
            }
        }
    }
}

#Preview {
    ContentView()
}
