//
//  Day5Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/5/21.
//

import Foundation

class Day5Challenge: Challenge {
    private var numOverlappingCoordinates = 0
    private var coordinatesVisited = Set<Coordinate>()
    private var coordinatesOverlapped = Set<Coordinate>()

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
        reset()
        let lines = parseInput()
        for line in lines {
            guard line.isHorizontal || line.isVertical else { continue }
            for coordinate in line.coordinates {
                if coordinatesVisited.contains(coordinate) {
                    guard !coordinatesOverlapped.contains(coordinate) else { continue }
                    coordinatesOverlapped.insert(coordinate)
                    numOverlappingCoordinates += 1
                } else {
                    coordinatesVisited.insert(coordinate)
                }
            }
        }

        answer = "\(numOverlappingCoordinates)"
    }

    override func part2() {
        reset()
        let lines = parseInput()
        for line in lines {
            guard line.isHorizontal || line.isVertical || line.isDiagonal else { continue }
            for coordinate in line.coordinates {
                if coordinatesVisited.contains(coordinate) {
                    guard !coordinatesOverlapped.contains(coordinate) else { continue }
                    coordinatesOverlapped.insert(coordinate)
                    numOverlappingCoordinates += 1
                } else {
                    coordinatesVisited.insert(coordinate)
                }
            }
        }

        answer = "\(numOverlappingCoordinates)"
    }

    private func reset() {
        self.numOverlappingCoordinates = 0
        self.coordinatesVisited.removeAll()
        self.coordinatesOverlapped.removeAll()
    }

    private func parseInput() -> [Line] {
        let lines = Utils.readFile("day5_input")
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

    var direction: Direction {
        if self.isDiagonal { return .diagonal }
        if self.isHorizontal { return .horizontal }
        if self.isVertical { return .vertical }
        return .unknown
    }

    enum Direction {
        case diagonal
        case horizontal
        case vertical
        case unknown
    }
}

fileprivate struct Coordinate: Equatable, Hashable {
    let x: Int
    let y: Int
}

fileprivate extension Line {
    var coordinates: [Coordinate] {
        var _coords: [Coordinate] = []
        switch self.direction {
        case.diagonal:
            let horizontalPositive = self.start.x < self.end.x
            let verticalPositive = self.start.y < self.end.y
            switch (horizontalPositive, verticalPositive) {
            case (true, true):
                var y = self.start.y
                for i in self.start.x...self.end.x {
                    _coords.append(.init(x: i, y: y))
                    y += 1
                }
            case (true, false):
                var y = self.start.y
                for i in self.start.x...self.end.x {
                    _coords.append(.init(x: i, y: y))
                    y -= 1
                }
            case (false, true):
                var y = self.end.y
                for i in self.end.x...self.start.x {
                    _coords.append(.init(x: i, y: y))
                    y -= 1
                }
            case (false, false):
                var y = self.end.y
                for i in self.end.x...self.start.x {
                    _coords.append(.init(x: i, y: y))
                    y += 1
                }
            }
            break

        case .horizontal:
            let y = self.start.y
            let (start, end) = self.start.x < self.end.x
            ? (self.start.x, self.end.x)
            : (self.end.x, self.start.x)

            for i in start...end {
                _coords.append(.init(x: i, y: y))
            }

        case .vertical:
            let x = self.start.x
            let (start, end) = self.start.y < self.end.y
            ? (self.start.y, self.end.y)
            : (self.end.y, self.start.y)

            for j in start...end {
                _coords.append(.init(x: x, y: j))
            }

        default: break
        }

        return _coords
    }

    var isVertical: Bool {
        self.start.x == self.end.x
    }

    var isHorizontal: Bool {
        self.start.y == self.end.y
    }

    var isDiagonal: Bool {
        return abs(self.end.y - self.start.y) == abs(self.end.x - self.start.x)
    }
}
