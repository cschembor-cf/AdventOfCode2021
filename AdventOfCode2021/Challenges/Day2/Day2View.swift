//
//  Day2View.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/2/21.
//

import SwiftUI

struct Day2View: View {
    @ObservedObject private var challenge = Day2Challenge()

    var body: some View {

        DayView(dayNumber: 2, challenge: challenge)
    }
}

struct Day2View_Previews: PreviewProvider {
    static var previews: some View {
        Day2View()
    }
}
