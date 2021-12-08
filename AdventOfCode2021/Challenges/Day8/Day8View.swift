//
//  Day8View.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/8/21.
//

import SwiftUI

struct Day8View: View {
    @ObservedObject private var challenge = Day8Challenge()

    var body: some View {

        DayView(dayNumber: 8, challenge: challenge)
    }
}

struct Day8View_Previews: PreviewProvider {
    static var previews: some View {
        Day8View()
    }
}
