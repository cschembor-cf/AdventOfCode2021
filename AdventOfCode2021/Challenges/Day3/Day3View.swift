//
//  Day3View.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/2/21.
//

import SwiftUI

struct Day3View: View {
    @ObservedObject private var challenge = Day3Challenge()

    var body: some View {

        DayView(dayNumber: 3, challenge: challenge)
    }
}

struct Day3View_Previews: PreviewProvider {
    static var previews: some View {
        Day3View()
    }
}
