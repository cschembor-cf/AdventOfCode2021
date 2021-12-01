//
//  Day1Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 11/30/21.
//

import Foundation

class Day1Challenge: ObservableObject {
    @Published var answer: String = ""

    func part1() {
        let lines = readFile("input")
        var numIncreases = 0
        for i in 0..<lines.count-1 {
            if Int(lines[i+1])! > Int(lines[i])! {
                numIncreases += 1
            }
        }

        answer = "\(numIncreases)"
    }

    func part2() {
        let lines = readFile("input")
        var numIncreases = 0
        var prevSum = 0
        for i in 0..<lines.count-2 {
            let currSum = lines[i...i+2].reduce(0) { acc, curr in
                acc + Int(curr)!
            }

            guard prevSum > 0 else {
                prevSum = currSum
                continue
            }

            if currSum > prevSum { numIncreases += 1}
            prevSum = currSum
        }

        answer = "\(numIncreases)"
    }

    private func readFile(_ name: String) -> [String.SubSequence] {
        let path = Bundle.main.path(forResource: "input", ofType: "txt")
        let fileContents = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        return fileContents.split(whereSeparator: \.isNewline)
    }
}
