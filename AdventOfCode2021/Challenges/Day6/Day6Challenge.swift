//
//  Day6Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/6/21.
//

import Foundation

class Day6Challenge: Challenge {
    let testInput = "3,4,3,1,2"

    var currentState: [Int] = []

    override func part1() {
        currentState = parseInput()
        let finalStates = getFinalStates(for: currentState, after: 80)
        answer = "\(finalStates.count)"
    }

    override func part2() {
        currentState = parseInput()
        let finalStates = getFinalStates(for: currentState, after: 256)
        answer = "\(finalStates.count)"
    }

    private func getFinalStates(for currStates: [Int], after numDays: Int) -> [Int] {
        var states = currStates
        for _ in 0..<numDays {
            var nextStates = states
                .filter { $0 == 0 }
                .map { _ in [6, 8] }
                .flatMap { $0 }

            nextStates.append(
                contentsOf: states.filter { $0 != 0 }.map { $0-1 }
            )

            states = nextStates
        }

        return states
    }

    private func parseInput() -> [Int] {
        let path = Bundle.main.path(forResource: "day6_input", ofType: "txt")
        let fileContents = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        return fileContents
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map { Int($0)! }
    }

}
