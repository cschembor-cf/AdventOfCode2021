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

    private func invertBinary(input: String) -> String {
        var output = ""
        input.forEach { char in
            output += char == "1" ? "0" : "1"
        }

        return output
    }
}
