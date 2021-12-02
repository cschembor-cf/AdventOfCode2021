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
        }
        .navigationBarHidden(true)
    }
}

struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengesView()
    }
}
