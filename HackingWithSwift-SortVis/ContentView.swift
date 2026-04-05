//
//  ContentView.swift
//  HackingWithSwift-SortVis
//
//  Created by Michael Jones on 05/04/2026.
//

import SwiftUI

struct ContentView: View {
    /*
     1. Give me the range between 1 to 100.
     2. Run each number though a function (in this case it's the SortValue initialiser. This function must accept one number.
     3. Then shuffles the entire array [SortValues].
    */
    @State private var values = (1...100).map(SortValue.init).shuffled()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("SortVis")
                .font(.largeTitle)
                .fontWeight(.black)
            
            GeometryReader { proxy in
                /*
                 1. Each value of the values property [SortValue] will display their value as a Rectangle within a HStack.
                 2. Each value will also have it's own unique colour based off the colour property in the SortValue struct.
                 3. The width of the Rectangle will be 1% of the available space. This will fill up the entire width seeing as we have 100 values in the array.
                 4. The height of the Rectangle is calculated by taking the entire height (100%) and timing it by the ID integer value (e.g., 10) then turning it into a percentage (10%). e.g., 100 * (10 / 100) = 10
                 */
                HStack(spacing: 0) {
                    ForEach(values) { value in
                        Rectangle()
                            .fill(value.colour)
                            .frame(width: proxy.size.width * 0.01, height: proxy.size.height * Double(value.id) / 100)
                    }
                }
            }
            .padding(.bottom)
        }
        .padding()
        .frame(minWidth: 500, minHeight: 400)
    }
}

#Preview {
    ContentView()
}
