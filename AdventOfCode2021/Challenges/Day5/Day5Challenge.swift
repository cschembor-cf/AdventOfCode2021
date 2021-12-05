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
            for coordinate in line.coordinates {
                if coordinatesVisited.contains(coordinate) {
                    guard !coordinatesOverlapped.contains(coordinate) else { continue }
                    coordinatesOverlapped.insert(coordinate)
                    overlappingCoordinates += 1
                } else {
                    coordinatesVisited.insert(coordinate)
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
}

fileprivate struct Line {
    let start: Coordinate
    let end: Coordinate
}

fileprivate struct Coordinate: Equatable, Hashable {
    let x: Int
    let y: Int
}

fileprivate extension Line {
    var coordinates: [Coordinate] {
        var _coords: [Coordinate] = []
        let horizontal = self.start.y == self.end.y
        let vertical = self.start.x == self.end.x
        if horizontal {
            let y = self.start.y
            let (start, end) = self.start.x < self.end.x
            ? (self.start.x, self.end.x)
            : (self.end.x, self.start.x)

            for i in start...end {
                _coords.append(.init(x: i, y: y))
            }
        } else if vertical {
            let x = self.start.x
            let (start, end) = self.start.y < self.end.y
            ? (self.start.y, self.end.y)
            : (self.end.y, self.start.y)

            for j in start...end {
                _coords.append(.init(x: x, y: j))
            }
        }

        return _coords
    }
}
