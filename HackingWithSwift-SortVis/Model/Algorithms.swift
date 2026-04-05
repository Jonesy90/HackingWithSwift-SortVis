//
//  Algorithms.swift
//  HackingWithSwift-SortVis
//
//  Created by Michael Jones on 05/04/2026.
//

import Foundation

/*
 The methods stored in this Array extension will only work with element types where a comparison can take place.
*/
extension Array where Element: Comparable {
    /*
     BubbleSort goes through all the elements in the array and compares their value against the one after them, then swaps their positions if they are in the wrong order. Once, it reaches the end of the array it goes round again and again until there isn't anymore swaps available.
    */
    mutating func bubbleSort() {
        for index in 0..<count - 1 {
            if self[index] > self[index + 1] {
                swapAt(index, index + 1)
            }
        }
    }
    
    /*
     InsertionSort is the closest to what humans do when they manually sort data. If we had an empty array in one place and an unsorted array in another, this works by moving through the items in the unsorted array and moving them into their correct positions in the sorted array.
     
     This works by picking out one item from the array, and moving it downwards in the array until it reaches an item it has sorted before.
    */
    mutating func insertionSort(startPosition: Int) -> Int {
        guard startPosition < count else { return startPosition }
        
        let itemToPlace = self[startPosition]
        var currentItemIndex = startPosition
        
        while currentItemIndex > 0 && itemToPlace < self[currentItemIndex - 1] {
            self[currentItemIndex] = self[currentItemIndex - 1]
            currentItemIndex -= 1
        }
        
        self[currentItemIndex] = itemToPlace
        return startPosition + 1
    }
    
    /*
     Quicksort is one of the most common sorting algorithms, it works by selecting a value at a random index in the array (called a Pivot Point) and dividing all the remaining data into three sections (objects before, after and are the same).
     
     It repeats this process for the before an after values and happens recursively until we're down to a single object, at which point the result can be stitched back together.
    */
    mutating func quickSort() {
        guard count > 1 else { return } // Exits if the array is empty.
        
        let pivot = self[Int.random(in: 0..<count)] // A random index pivot point in the array.
        let before = self.filter { $0 < pivot } // Looks at the entire array and creates a new array of all the elements which are before the pivot point value.
        let after = self.filter { $0 > pivot } // Looks at the entire array and creates a new array of all the elements which are after the pivot point value.
        let equal = self.filter { $0 == pivot } // Looks at the entire array and creates a new array of all the elements that equal the pivot point value.
        
        self = before + equal + after
    }
}
