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

        VStack {
            Spacer()
            Button(action: {
                challenge.part1()
            }) {
                RunButtonView(title: "Part 1")
            }

            if !challenge.answer.isEmpty {
                Text("Output: \(challenge.answer)")
                    .font(.largeTitle)
            }

            Button(action: {
                challenge.part2()
            }) {
                RunButtonView(title: "Part 2")
            }

            Spacer()
        }
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

struct Day1View_Previews: PreviewProvider {
    static var previews: some View {
        Day1View()
    }
}
