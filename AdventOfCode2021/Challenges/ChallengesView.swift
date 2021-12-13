//
//  ChallengesView.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 11/30/21.
//

import SwiftUI

struct ChallengesView: View {
    var body: some View {
        
        List {
            NavigationLink("Day 1") {
                Day1View()
            }
            NavigationLink("Day 2") {
                Day2View()
            }
            NavigationLink("Day 3") {
                Day3View()
            }
            NavigationLink("Day 4") {
                Day4View()
            }
            NavigationLink("Day 5") {
                Day5View()
            }
            NavigationLink("Day 6") {
                Day6View()
            }
            NavigationLink("Day 7") {
                Day7View()
            }
            NavigationLink("Day 8") {
                Day8View()
            }
            NavigationLink("Day 9") {
                Day9View()
            }
        }
        .navigationBarHidden(true)
    }
}

struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
    }
}
