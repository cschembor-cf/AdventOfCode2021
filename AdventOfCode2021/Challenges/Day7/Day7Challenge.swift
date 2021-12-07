//
//  Day7Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/7/21.
//

import Foundation

class Day7Challenge: Challenge {

    let testInput = "16,1,2,0,4,2,7,1,2,14"

    // {0:1, 1:2, 2:3, 4:1, 7:1, 14:1, 16:1}

    override func part1() {
        let input = parseInput()
        let dict = constructDict(for: input)
        answer = "\(calculateMinimumFuel(positionsCount: dict))"
    }

    private func calculateMinimumFuel(positionsCount: Dictionary<Int, Int>) -> Int {
        var minDistance: Int? = nil
        for i in positionsCount.keys {
            let currDistance = positionsCount.keys
                .reduce(0) { acc, curr in
                    return acc + (abs(curr - i) * positionsCount[curr]!)
                }

            if minDistance == nil {
                minDistance = currDistance
                continue
            }

            if let minDist = minDistance, currDistance < minDist { minDistance = currDistance }
        }

        return minDistance ?? 0
    }

    private func constructDict(for input: [Int]) -> Dictionary<Int, Int> {
        var positionsAndCount = Dictionary<Int, Int>()
        for pos in input {
            if let currCount = positionsAndCount[pos] {
                positionsAndCount.updateValue(currCount+1, forKey: pos)
            } else {
                positionsAndCount[pos] = 1
            }
        }

        return positionsAndCount
    }

    private func parseInput() -> [Int] {
        let path = Bundle.main.path(forResource: "day7_input", ofType: "txt")
        let fileContents = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        return fileContents.split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map { Int($0)! }
    }
}
