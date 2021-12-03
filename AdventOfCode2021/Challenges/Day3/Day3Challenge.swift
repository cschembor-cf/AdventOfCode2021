//
//  Day3Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/2/21.
//

import Foundation

class Day3Challenge: Challenge {
    let testInput = """
        00100
        11110
        10110
        10111
        10101
        01111
        00111
        11100
        10000
        11001
        00010
        01010
    """

    override func part1() {
        var gammaRate = ""
        var epsilonRate = ""
        let lines = Utils.readFile("day3_input")
        let numLines = lines.count
        let numChars = lines.first!.count
        for i in 0..<numChars {
            let sum = lines
                .map { String($0) }
                .map { line -> Character in
                    let index = line.index(line.startIndex, offsetBy: i)
                    return line[index]
                }
                .map { $0.wholeNumberValue! }
                .reduce(0, +)

            gammaRate += sum > (numLines/2) ? "1" : "0"
        }

        epsilonRate = invertBinary(input: gammaRate)

        answer = "\(Utils.binaryToDecimal(gammaRate) * Utils.binaryToDecimal(epsilonRate))"
    }

    override func part2() {
        let lines = Utils.readFile("day3_input").map { String($0) }
        let oxygenRating = getOxygenGeneratorRating(lines: lines, index: 0)
        let scrubbingRating = getCO2ScrubbingRating(lines: lines, index: 0)
        answer = "\(Utils.binaryToDecimal(oxygenRating) * Utils.binaryToDecimal(scrubbingRating))"
    }

    private func getOxygenGeneratorRating(lines: [String], index: Int) -> String {
        guard lines.count > 1 else { return String(lines.first!) }
        let bit = getMostCommonBit(from: lines, for: index)
        let remainingLines = filterLines(lines, index: index, matchingBit: Character(bit))
        return getOxygenGeneratorRating(lines: remainingLines, index: index+1)
    }

    private func getCO2ScrubbingRating(lines: [String], index: Int) -> String {
        guard lines.count > 1 else { return String(lines.first!) }
        let bit = getLeastCommonBit(from: lines, for: index)
        let remainingLines = filterLines(lines, index: index, matchingBit: Character(bit))
        return getCO2ScrubbingRating(lines: remainingLines, index: index+1)
    }

    private func filterLines(_ lines: [String], index: Int, matchingBit: Character) -> [String] {
        lines
            .map { String($0) }
            .filter { line in
                let i = line.index(line.startIndex, offsetBy: index)
                return line[i] == matchingBit
            }
    }

    private func invertBinary(input: String) -> String {
        var output = ""
        input.forEach { char in
            output += char == "1" ? "0" : "1"
        }

        return output
    }

    private func getMostCommonBit(from lines: [String], for index: Int) -> String {
        let sum = lines
            .map { String($0) }
            .map { line -> Character in
                let index = line.index(line.startIndex, offsetBy: index)
                return line[index]
            }
            .map { $0.wholeNumberValue! }
            .reduce(0, +)

        return Double(sum) >= (Double(lines.count) / 2.0) ? "1" : "0"
    }

    private func getLeastCommonBit(from lines: [String], for index: Int) -> String {
        return getMostCommonBit(from: lines, for: index) == "1" ? "0" : "1"
    }
}
