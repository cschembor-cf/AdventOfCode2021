//
//  Day5View.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/5/21.
//

import SwiftUI

struct Day5View: View {
    @ObservedObject private var challenge = Day5Challenge()

    var body: some View {

        DayView(dayNumber: 5, challenge: challenge)
    }
}

struct Day5View_Previews: PreviewProvider {
    static var previews: some View {
        Day5View()
    }
}
