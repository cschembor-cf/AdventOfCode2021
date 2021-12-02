//
//  DayView.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/1/21.
//

import SwiftUI

struct DayView: View {

    private let dayNumber: Int
    @ObservedObject private var challenge: Challenge

    init(dayNumber: Int, challenge: Challenge) {
        self.dayNumber = dayNumber
        self.challenge = challenge
    }

    var body: some View {

        VStack {

            Text("Day 1")
                .font(.largeTitle)
                .bold()
                .padding()

            Spacer()

            Text("Output: \(challenge.answer)")
                .font(.largeTitle)
                .opacity(challenge.answer.isEmpty ? 0 : 1)

            Button(action: {
                challenge.part1()
            }) {
                RunButtonView(title: "Part 1")
            }

            Button(action: {
                challenge.part2()
            }) {
                RunButtonView(title: "Part 2")
            }

            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct RunButtonView: View {

    private let title: String
    init(title: String) {
        self.title = title
    }

    var body: some View {

        ZStack {
            Capsule(style: .continuous)
                .fill(.blue)
                .frame(width: 150, height: 75, alignment: .center)

            Text(title)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(dayNumber: 1, challenge: Day1Challenge())
    }
}
