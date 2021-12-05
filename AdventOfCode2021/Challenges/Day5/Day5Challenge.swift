//
//  Day5Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/5/21.
//

import Foundation

class Day5Challenge: Challenge {
    let testInput = """
        0,9 -> 5,9
        8,0 -> 0,8
        9,4 -> 3,4
        2,2 -> 2,1
        7,0 -> 7,4
        6,4 -> 2,0
        0,9 -> 2,9
        3,4 -> 1,4
        0,0 -> 8,8
        5,5 -> 8,2
    """

    override func part1() {
        var overlappingCoordinates = 0
        var coordinatesVisited = Set<Coordinate>()
        var coordinatesOverlapped = Set<Coordinate>()
        let lines = parseInput()
        for line in lines {
            let horizontal = line.start.y == line.end.y
            let vertical = line.start.x == line.end.x
            guard horizontal || vertical else { continue }
            if horizontal {
                let y = line.start.y
                let (start, end) = line.start.x < line.end.x
                    ? (line.start.x, line.end.x)
                    : (line.end.x, line.start.x)

                for i in start...end {
                    let curr = Coordinate(x: i, y: y)
                    if coordinatesVisited.contains(curr) {
                        guard !coordinatesOverlapped.contains(curr) else { continue }
                        coordinatesOverlapped.insert(curr)
                        print("Horizontal -> \(curr)")
                        overlappingCoordinates += 1
                    } else {
                        coordinatesVisited.insert(.init(x: i, y: y))
                    }
                }
            } else {
                let x = line.start.x
                let (start, end) = line.start.y < line.end.y
                    ? (line.start.y, line.end.y)
                    : (line.end.y, line.start.y)

                for j in start...end {
                    let curr = Coordinate(x: x, y: j)
                    if coordinatesVisited.contains(.init(x: x, y: j)) {
                        guard !coordinatesOverlapped.contains(curr) else { continue }
                        coordinatesOverlapped.insert(curr)
                        print("Vertical -> \(curr)")
                        overlappingCoordinates += 1
                    } else {
                        coordinatesVisited.insert(.init(x: x, y: j))
                    }
                }
            }
        }

        answer = "\(overlappingCoordinates)"
    }

    private func parseInput() -> [Line] {
        let lines = Utils.readFile("day5_input")//testInput.split(whereSeparator: \.isNewline).map { $0.trimmingCharacters(in: .whitespaces) } // Utils.readFile("day5_input")

        var output: [Line] = []
        for line in lines {
            let coords: [Coordinate] = line.components(separatedBy: "->")
                .map { $0.trimmingCharacters(in: .whitespaces) }
                .map { $0.split(separator: ",") }
                .map { Coordinate(x: Int($0[0])!, y: Int($0[1])!) }

            output.append(.init(start: coords[0], end: coords[1]))
        }

        return output
    }

    struct Line {
        let start: Coordinate
        let end: Coordinate
    }

    struct Coordinate: Equatable, Hashable {
        let x: Int
        let y: Int
    }
}
