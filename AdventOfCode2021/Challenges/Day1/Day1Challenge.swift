//
//  Day1Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 11/30/21.
//

import Foundation

class Day1Challenge: Challenge {
    
    override func part1() {
        let lines = Utils.readFile("input")
        var numIncreases = 0
        for i in 0..<lines.count-1 {
            if Int(lines[i+1])! > Int(lines[i])! {
                numIncreases += 1
            }
        }

        answer = "\(numIncreases)"
    }

    override func part2() {
        let lines = Utils.readFile("input")
        var numIncreases = 0
        var prevSum = 0
        for i in 0..<lines.count-2 {
            let currSum = lines[i...i+2]
                .map { Int($0)! }
                .reduce(0, +)

            guard prevSum > 0 else {
                prevSum = currSum
                continue
            }

            if currSum > prevSum { numIncreases += 1}
            prevSum = currSum
        }

        answer = "\(numIncreases)"
    }
}
