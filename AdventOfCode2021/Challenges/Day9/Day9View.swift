//
//  Day9View.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/12/21.
//

import SwiftUI

struct Day9View: View {
    @ObservedObject private var challenge = Day9Challenge()

    var body: some View {

        DayView(dayNumber: 9, challenge: challenge)
    }
}

struct Day9View_Previews: PreviewProvider {
    static var previews: some View {
        Day9View()
    }
}
