//
//  Day1View.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 11/30/21.
//

import SwiftUI

struct Day1View: View {
    @ObservedObject private var challenge = Day1Challenge()

    var body: some View {

        DayView(dayNumber: 1, challenge: challenge)
    }
}

struct Day1View_Previews: PreviewProvider {
    static var previews: some View {
        Day1View()
    }
}
