//
//  SortValue.swift
//  HackingWithSwift-SortVis
//
//  Created by Michael Jones on 05/04/2026.
//

import SwiftUI

/*
 1. The identifier will represent the value of the object, which will be used for sorting and sizing.
 2. An identifier to calculate the unique colour for each value on the screen, so it's clearer to users when sorting is done correctly.
 3. Making the struct conform to the Comparable protocol means we can always compare two instances of the SortValue directly.
*/
struct SortValue: Comparable, Identifiable {
    var id: Int
    
    var colour: Color {
        Color(hue: Double(id) / 100, saturation: 1, brightness: 1)
    }
    
    static func < (lhs: SortValue, rhs: SortValue) -> Bool {
        lhs.id < rhs.id
    }
}
