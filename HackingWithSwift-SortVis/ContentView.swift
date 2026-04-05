//
//  ContentView.swift
//  HackingWithSwift-SortVis
//
//  Created by Michael Jones on 05/04/2026.
//

import SwiftUI
internal import Combine

struct ContentView: View {
    /*
     An enum to allow us to switch between different sort types.
    */
    enum SortTypes: String, CaseIterable {
        case bubble = "Bubble Sort"
        case insertion = "Insertion Sort"
    }
    
    /*
     1. Give me the range between 1 to 100.
     2. Run each number though a function (in this case it's the SortValue initialiser. This function must accept one number.
     3. Then shuffles the entire array [SortValues].
    */
    @State private var values = (1...100).map(SortValue.init).shuffled()
    
    // A timer property that can be watched and actioned upon.
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    // A property to work alongside the Slider View in the body.
    @State private var timerSpeed = 0.1
    
    // A property to track the current insertion sort position.
    @State private var insertionSortPosition = 1
    
    // A property to store the current sortFunction.
    @State private var sortFunction = SortTypes.bubble
    
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
            
            Picker("Sort Types", selection: $sortFunction) {
                ForEach(SortTypes.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            HStack(spacing: 20) {
                LabeledContent("Speed") {
                    Slider(value: $timerSpeed, in: 0...1)
                }
                .frame(maxWidth: 400)
                
                Button("Step", action: step) // a button that triggers one BubbleSort step.
                
                // A button to shuffle the values stored in the values array [SortVis].
                Button("Shuffle") {
                    withAnimation {
                        values.shuffle()
                        insertionSortPosition = 1 // Whenever we shuffle the array, the insertionSortPosition property needs to be reset.
                    }
                }
            }
        }
        .padding()
        .frame(minWidth: 500, minHeight: 400)
        
        // This executes the 'step' function every time the timer property fires.
        .onReceive(timer) { _ in
            step()
        }
        
        /*
         1. If the 'timerSpeed' property value changes, stop the timer property from firing.
         2. If the 'timerSpeed' is not equal to 0, then restart the timer property with the new 'timerSpeed' passed in via the slider.
        */
        .onChange(of: timerSpeed) {
            timer.upstream.connect().cancel()
            
            if timerSpeed != 0 {
                timer = Timer.publish(every: timerSpeed, on: .main, in: .common).autoconnect()
            }
        }
    }
    
    
    /// A method that applies the correct sort method depending on the sortFunction property value.
    func step() {
        withAnimation {
            switch sortFunction {
            case .bubble:
                values.bubbleSort()
            case .insertion:
                insertionSortPosition = values.insertionSort(startPosition: insertionSortPosition)
            }
        }
    }
}

#Preview {
    ContentView()
}
