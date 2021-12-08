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
        let accFunc = accWithConstantFuel
        answer = "\(calculateMinimumFuel(positionsCount: dict, accFunc: accFunc))"
    }

    override func part2() {
        let input = parseInput()
        let dict = constructDict(for: input)
        let accFunc = accWithIncreasingFuel
        answer = "\(calculateMinimumFuel(positionsCount: dict, accFunc: accFunc))"
    }


    /**
     1 -> 1
     2 -> f(1) + 2 -> 1 + 2 = 3
     3 -> f(2) + 3 -> 1 + 2 + 3 = 6
     4 -> f(3) + 4 -> 1 + 2 + 3 + 4 = 10
     5 -> f(4) + 5 -> 1 + 2 + 3 + 4 + 5 = 15
     */

    private func calculateMinimumFuel(
        positionsCount: [Int: Int],
        accFunc: (Int, Int, Int) -> Int
    ) -> Int {
        var minDistance: Int? = nil
        for i in positionsCount.keys.min()!...positionsCount.keys.max()! {
            let currDistance = positionsCount.keys
                .reduce(0) { acc, curr in
                    let dist = abs(curr - i)
                    let numAtDist = positionsCount[curr]!
                    return accFunc(dist, numAtDist, acc)
                }

            if minDistance == nil {
                minDistance = currDistance
                continue
            }

            if let minDist = minDistance, currDistance < minDist { minDistance = currDistance }
        }

        return minDistance ?? 0
    }

    private func calculateFuelCost(for distance: Int) -> Int {
        guard distance > 0 else { return 0 }
        guard distance > 1 else { return 1 }
        return distance + calculateFuelCost(for: distance - 1)
    }

    private func accWithIncreasingFuel(dist: Int, numAtDist: Int, acc: Int) -> Int {
        let fuelCost = calculateFuelCost(for: dist) * numAtDist
        return acc + fuelCost
    }

    private func accWithConstantFuel(dist: Int, numAtDist: Int, acc: Int) -> Int {
        return acc + (dist * numAtDist)
    }

    private func constructDict(for input: [Int]) -> [Int: Int] {
        var positionsAndCount: [Int: Int] = [:]
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
