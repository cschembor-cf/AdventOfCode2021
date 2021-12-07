//
//  Day7View.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/7/21.
//

import SwiftUI

struct Day7View: View {
    @ObservedObject private var challenge = Day7Challenge()

    var body: some View {

        DayView(dayNumber: 7, challenge: challenge)
    }
}

struct Day7View_Previews: PreviewProvider {
    static var previews: some View {
        Day7View()
    }
}
