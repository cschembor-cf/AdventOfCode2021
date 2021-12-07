//
//  Day6Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/6/21.
//

import Foundation

class Day6Challenge: Challenge {
    let testInput = "3,4,3,1,2"

    var currentStates: [Int] = []

    override func part1() {
        currentStates = parseInput()
        answer = "\(getNumFish(given: currentStates, after: 80))"
    }

    override func part2() {
        currentStates = parseInput()
        answer = "\(getNumFish(given: currentStates, after: 256))"
    }

    private func getNumFish(given states: [Int], after numDays: Int) -> Int {
        let finalStateBuckets = getFinalStates(for: states, after: numDays)
        return finalStateBuckets.zeroes +
            finalStateBuckets.ones +
            finalStateBuckets.twos +
            finalStateBuckets.threes +
            finalStateBuckets.fours +
            finalStateBuckets.fives +
            finalStateBuckets.sixes +
            finalStateBuckets.sevens +
            finalStateBuckets.eights
    }

    private func getFinalStates(for currStates: [Int], after numDays: Int) -> StateBuckets {
        var stateBuckets = StateBuckets(with: currStates)
        for _ in 0..<numDays {
            let ones = stateBuckets.ones
            stateBuckets.ones = stateBuckets.twos
            stateBuckets.twos = stateBuckets.threes
            stateBuckets.threes = stateBuckets.fours
            stateBuckets.fours = stateBuckets.fives
            stateBuckets.fives = stateBuckets.sixes
            stateBuckets.sixes = stateBuckets.sevens
            stateBuckets.sevens = stateBuckets.eights
            stateBuckets.eights = stateBuckets.zeroes
            stateBuckets.sixes += stateBuckets.zeroes
            stateBuckets.zeroes = ones
        }

        return stateBuckets
    }

    private func parseInput() -> [Int] {
        let path = Bundle.main.path(forResource: "day6_input", ofType: "txt")
        let fileContents = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        return fileContents
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map { Int($0)! }
    }

    struct StateBuckets {
        var zeroes: Int
        var ones: Int
        var twos: Int
        var threes: Int
        var fours: Int
        var fives: Int
        var sixes: Int
        var sevens: Int
        var eights: Int

        init(with states: [Int]) {
            self.zeroes = states.filter { $0 == 0 }.count
            self.ones = states.filter { $0 == 1 }.count
            self.twos = states.filter { $0 == 2}.count
            self.threes = states.filter { $0 == 3 }.count
            self.fours = states.filter { $0 == 4 }.count
            self.fives = states.filter { $0 == 5 }.count
            self.sixes = states.filter { $0 == 6 }.count
            self.sevens = states.filter { $0 == 7 }.count
            self.eights = states.filter { $0 == 8 }.count
        }
    }
}
