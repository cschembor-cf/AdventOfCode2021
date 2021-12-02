//
//  Day2Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/2/21.
//

import Foundation

class Day2Challenge: Challenge {

    var testInput = """
        forward 5
        down 5
        forward 8
        up 3
        down 8
        forward 2
"""

    override func part1() {
        var horizontalPos = 0
        var depth = 0
        let lines = Utils.readFile("day2_input")
        for line in lines {
            let inputs = line.split(separator: " ")
            if let command = PosCommand(dir: String(inputs[0]), amount: Int(inputs[1])!) {
                let posUpdate = command.getFinalPos()
                horizontalPos += posUpdate.horizontalPos
                depth += posUpdate.depth
            }
        }

        answer = "\(horizontalPos * depth)"
    }

    override func part2() {
        var horizontalPos = 0
        var depth = 0
        var aim = 0
        let lines = Utils.readFile("day2_input")
        for line in lines {
            let inputs = line.split(separator: " ")
            if let command = PosCommand(dir: String(inputs[0]), amount: Int(inputs[1])!) {
                switch (command) {
                case .down(let amount):
                    aim += amount
                case .up(let amount):
                    aim -= amount
                case .forward(let amount):
                    horizontalPos += amount
                    depth += aim * amount
                }
            }
        }

        answer = "\(horizontalPos * depth)"
    }

    enum PosCommand {
        case forward(_ amount: Int)
        case up(_ amount: Int)
        case down(_ amount: Int)

        init?(dir: String, amount: Int) {
            switch (dir) {
            case "forward":
                self = .forward(amount)
            case "up":
                self = .up(amount)
            case "down":
                self = .down(amount)
            default:
                return nil
            }
        }

        func getFinalPos() -> (horizontalPos: Int, depth: Int) {

            switch (self) {
            case .forward(let amount):
                return (horizontalPos: amount, depth: 0)
            case .up(let amount):
                return (horizontalPos: 0, depth: -amount)
            case .down(let amount):
                return (horizontalPos: 0, depth: amount)
            }
        }
    }
}
