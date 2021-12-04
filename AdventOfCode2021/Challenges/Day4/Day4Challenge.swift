//
//  Day4Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/4/21.
//

import Foundation

class Day4Challenge: Challenge {

    let testInput = """
        7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

        22 13 17 11  0
         8  2 23  4 24
        21  9 14 16  7
         6 10  3 18  5
         1 12 20 15 19

         3 15  0  2 22
         9 18 13 17  5
        19  8  7 25 23
        20 11 10 24  4
        14 21 16 12  6

        14 21 17 24  4
        10 16 15  9 19
        18  8 23 26 20
        22 11 13  6  5
         2  0 12  3  7
    """

    override func part1() {
        let (drawnNumbers, boards) = parseInput(fileName: "day4_input")
        // 🤢
        for num in drawnNumbers {
            for board in boards {
                markBoard(board, number: num)
                if board.hasBingo {
                    answer = "\(getFinalValue(for: board, with: num))"
                    return
                }
            }
        }
    }

    override func part2() {
        let (drawnNumbers, boards) = parseInput(fileName: "day4_input")
        var lastBoardToBingo: BingoBoard? = nil
        var lastNum: Int? = nil
        var filteredBoards = boards
        while !filteredBoards.isEmpty {
            for num in drawnNumbers {
                for board in filteredBoards {
                    markBoard(board, number: num)
                    if board.hasBingo {
                        lastBoardToBingo = board
                        lastNum = num
                        filteredBoards.removeAll { b in
                            b == board
                        }
                    }
                }
            }
        }

        answer = "\(getFinalValue(for: lastBoardToBingo!, with: lastNum!))"
    }

    private func getFinalValue(for board: BingoBoard, with winningNumber: Int) -> Int {
        let unmarkedSum = board.board
            .flatMap { $0 }
            .filter { !$0.isSelected }
            .reduce(0) { acc, curr in
                acc + curr.number
            }

        return unmarkedSum * winningNumber
    }

    private func markBoard(_ board: BingoBoard, number: Int) {
        for i in 0..<board.board.count {
            for j in 0..<board.board[i].count {
                if board.board[i][j].number == number {
                    board.board[i][j].setSelected()
                }
            }
        }
    }

    private func parseInput(fileName: String) -> (drawnNumbers: [Int], boards: [BingoBoard]) {
        let path = Bundle.main.path(forResource: fileName, ofType: "txt")
        let fileContents = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        let parsedContents = fileContents.components(separatedBy: "\n\n")
        let drawnNumbers = parsedContents.first!.split(separator: ",").map { Int($0.trimmingCharacters(in: .whitespaces))! }
        var boards: [BingoBoard] = []
        for i in 1..<parsedContents.count {
            let board = BingoBoard()
            for line in parsedContents[i].components(separatedBy: .newlines) {
                let row = line.split(separator: " ").map { Int($0)! }
                if !row.isEmpty {
                    board.addRow(row)
                }
            }
            boards.append(board)
        }

        return (drawnNumbers, boards)
    }

    class BingoBoard: Equatable {
        static func == (lhs: Day4Challenge.BingoBoard, rhs: Day4Challenge.BingoBoard) -> Bool {
            lhs.board == rhs.board
        }

        var board: [[BingoNumber]] = []

        func addRow(_ row: [Int]) {
            self.board.append(row.map { BingoNumber(num: $0) })
        }

        var hasBingo: Bool {
            //if hasDiagonalBingo() { return true }
            for i in 0..<self.board.count {
                if hasHorizontalBingo(row: i) { return true }
            }

            for i in 0..<self.board.first!.count {
                if hasVerticalBingo(column: i) { return true }
            }

            return false
        }

        private func hasDiagonalBingo() -> Bool {
            self.board[0][0].isSelected &&
            self.board[1][1].isSelected &&
            self.board[2][2].isSelected &&
            self.board[3][3].isSelected &&
            self.board[4][4].isSelected
        }

        private func hasVerticalBingo(column: Int) -> Bool {
            self.board[column][0].isSelected &&
            self.board[column][1].isSelected &&
            self.board[column][2].isSelected &&
            self.board[column][3].isSelected &&
            self.board[column][4].isSelected
        }

        private func hasHorizontalBingo(row: Int) -> Bool {
            self.board[0][row].isSelected &&
            self.board[1][row].isSelected &&
            self.board[2][row].isSelected &&
            self.board[3][row].isSelected &&
            self.board[4][row].isSelected
        }

        struct BingoNumber: Equatable {
            let number: Int
            var isSelected: Bool

            init(num: Int) {
                self.number = num
                self.isSelected = false
            }

            mutating func setSelected() {
                self.isSelected = true
            }
        }
    }
}
