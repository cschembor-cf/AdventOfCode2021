//
//  Day6View.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/6/21.
//

import SwiftUI

struct Day6View: View {
    @ObservedObject private var challenge = Day6Challenge()

    var body: some View {

        DayView(dayNumber: 6, challenge: challenge)
    }
}

struct Day6View_Previews: PreviewProvider {
    static var previews: some View {
        Day6View()
    }
}
