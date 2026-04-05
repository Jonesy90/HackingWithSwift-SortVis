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
}
