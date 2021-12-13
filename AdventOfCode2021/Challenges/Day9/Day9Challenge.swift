//
//  Day9Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/12/21.
//

import Foundation

class Day9Challenge: Challenge {

    let testInput = """
        2199943210
        3987894921
        9856789892
        8767896789
        9899965678
    """

    override func part1() {
        let input = parseInput()
        let adjacentHeights = constructAdjacentHeightsDict(input)
        let riskLevels = findRiskLevels(input: input, adjacentsDict: adjacentHeights)
        answer = "\(riskLevels.reduce(0, +))"
    }

    private func findRiskLevels(input: [[Int]], adjacentsDict: [Index: [Index]]) -> [Int] {
        var minHeights: [Int] = []
        for index in adjacentsDict.keys {
            let currHeight = input[index.y][index.x]
            if adjacentsDict[index]!.allSatisfy({ currHeight < input[$0.y][$0.x] }) {
                minHeights.append(currHeight)
            }
        }

        return minHeights.map { $0 + 1 }
    }

    private func constructAdjacentHeightsDict(_ input: [[Int]]) -> [Index: [Index]] {
        var adjacentHeights: [Index: [Index]] = [:]
        for i in 0..<input.count {
            for j in 0..<input[i].count {
                let x = j
                let y = i
                let index = Index(x: x, y: y)
                switch (x, y) {
                case (0, 0):
                    let neighbors = [Index(x: x+1, y: y), Index(x: x, y: y+1)]
                    adjacentHeights[index] = neighbors
                case (input[y].count-1, input.count-1):
                    let neighbors = [Index(x: x-1, y: y), Index(x: x, y: y-1)]
                    adjacentHeights[index] = neighbors
                case (0, input.count-1):
                    let neighbors = [Index(x: x+1, y: y), Index(x: x, y: y-1)]
                    adjacentHeights[index] = neighbors
                case (input[y].count-1, 0):
                    let neighbors = [Index(x: x-1, y: y), Index(x: x, y: y+1)]
                    adjacentHeights[index] = neighbors
                case (0, _):
                    let neighbors = [Index(x: x+1, y: y), Index(x: x, y: y+1), Index(x: x, y: y-1)]
                    adjacentHeights[index] = neighbors
                case (_, 0):
                    let neighbors = [Index(x: x+1, y: y), Index(x: x-1, y: y), Index(x: x, y: y+1)]
                    adjacentHeights[index] = neighbors
                case (_, input.count-1):
                    let neighbors = [Index(x: x, y: y-1), Index(x: x-1, y: y), Index(x: x+1, y: y)]
                    adjacentHeights[index] = neighbors
                case (input[y].count-1, _):
                    let neighbors = [Index(x: x, y: y-1), Index(x: x, y: y+1), Index(x: x-1, y: y)]
                    adjacentHeights[index] = neighbors
                case(_, _):
                    let neighbors = [Index(x: x+1, y: y), Index(x: x-1, y: y), Index(x: x, y: y+1), Index(x: x, y: y-1)]
                    adjacentHeights[index] = neighbors
                }
            }
        }

        return adjacentHeights
    }

    private func parseInput() -> [[Int]] {
        let lines = Utils.readFile("day9_input")
        var output = [[Int]](repeating: [Int](repeating: -1, count: lines.first!.count), count: lines.count)
        for (i, line) in lines.enumerated() {
            for (j, char) in line.enumerated() {
                output[i][j] = char.wholeNumberValue ?? -1
            }
        }

        return output
    }

    struct Index: Equatable, Hashable {
        let x: Int
        let y: Int
    }
}
