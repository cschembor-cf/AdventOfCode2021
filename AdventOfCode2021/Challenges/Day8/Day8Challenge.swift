//
//  Day8Challenge.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/8/21.
//

import Foundation

class Day8Challenge: Challenge {

    let testInput = """
        be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
        edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
        fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
        fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
        aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
        fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
        dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
        bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
        egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
        gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
   """

    let testInput2 = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"

    let possibleCharacters: [Character] = ["a", "b", "c", "d", "e", "f", "g"]

    override func part1() {
        let entries = parseInput()
        var easyDigitsCount = 0

        for entry in entries {
            var easyDigitsSorted: [String] = []
            for input in entry.inputs {
                if isEasyDigit(input) {
                    easyDigitsSorted.append(String(input.sorted()))
                }
            }

            for output in entry.outputs {
                if easyDigitsSorted.contains(String(output.sorted())) {
                    easyDigitsCount += 1
                }
            }
        }

        answer = "\(easyDigitsCount)"
    }

    override func part2() {
        let entries = parseInput()
        var outputs: [Int] = []
        for entry in entries {
            var potentialSegments = initPotentialSegmentsDict()
            let isKnown: (String) -> Bool = { str in str.isOne || str.isFour || str.isSeven }
            let knownVals = entry.inputs
                .filter(isKnown)

            let unknownVals = entry.inputs
                .filter { !isKnown($0) }

            for val in knownVals {
                let chars = Array(val)
                switch val {
                case let i where i.isOne:
                    potentialSegments[.upperRight] = filterVals(potentialSegments, from: .upperRight, vals: chars)
                    potentialSegments[.lowerRight] = filterVals(potentialSegments, from: .lowerRight, vals: chars)

                    potentialSegments[.upperLeft] = removeVals(potentialSegments, from: .upperLeft, vals: chars)
                    potentialSegments[.top] = removeVals(potentialSegments, from: .top, vals: chars)
                    potentialSegments[.middle] = removeVals(potentialSegments, from: .middle, vals: chars)
                    potentialSegments[.lowerLeft] = removeVals(potentialSegments, from: .lowerLeft, vals: chars)
                    potentialSegments[.bottom] = removeVals(potentialSegments, from: .bottom, vals: chars)

                case let i where i.isFour:
                    potentialSegments[.upperLeft] = filterVals(potentialSegments, from: .upperLeft, vals: chars)
                    potentialSegments[.middle] = filterVals(potentialSegments, from: .middle, vals: chars)
                    potentialSegments[.upperRight] = filterVals(potentialSegments, from: .upperRight, vals: chars)
                    potentialSegments[.lowerRight] = filterVals(potentialSegments, from: .lowerRight, vals: chars)

                    potentialSegments[.top] = removeVals(potentialSegments, from: .top, vals: chars)
                    potentialSegments[.lowerLeft] = removeVals(potentialSegments, from: .lowerLeft, vals: chars)
                    potentialSegments[.bottom] = removeVals(potentialSegments, from: .bottom, vals: chars)

                case let i where i.isSeven:
                    potentialSegments[.top] = filterVals(potentialSegments, from: .top, vals: chars)
                    potentialSegments[.upperRight] = filterVals(potentialSegments, from: .upperRight, vals: chars)
                    potentialSegments[.lowerRight] = filterVals(potentialSegments, from: .lowerRight, vals: chars)

                    potentialSegments[.upperLeft] = removeVals(potentialSegments, from: .upperLeft, vals: chars)
                    potentialSegments[.middle] = removeVals(potentialSegments, from: .middle, vals: chars)
                    potentialSegments[.lowerLeft] = removeVals(potentialSegments, from: .lowerLeft, vals: chars)
                    potentialSegments[.bottom] = removeVals(potentialSegments, from: .bottom, vals: chars)

                default:
                    break
                }
            }

            var workingChars: [[SegmentType: [Character]]] = [[:]]
            for val in unknownVals {
                let chars = Array(val)
                if val.count == 6 {
                    if !filterVals(potentialSegments, from: .top, vals: chars).isEmpty &&
                        !filterVals(potentialSegments, from: .upperLeft, vals: chars).isEmpty &&
                        !filterVals(potentialSegments, from: .middle, vals: chars).isEmpty &&
                        !filterVals(potentialSegments, from: .upperRight, vals: chars).isEmpty &&
                        !filterVals(potentialSegments, from: .lowerRight, vals: chars).isEmpty &&
                        !filterVals(potentialSegments, from: .bottom, vals: chars).isEmpty {

                        var charsLeft = chars

                        for a in potentialSegments[.top]! {
                            charsLeft = charsLeft.filter { $0 != a }
                            for b in potentialSegments[.upperLeft]! {
                                guard charsLeft.contains(b) else { continue }
                                charsLeft = charsLeft.filter { $0 != b }
                                for c in potentialSegments[.middle]! {
                                    guard charsLeft.contains(c) else { continue }
                                    charsLeft = charsLeft.filter { $0 != c }
                                    for d in potentialSegments[.upperRight]! {
                                        guard charsLeft.contains(d) else { continue }
                                        charsLeft = charsLeft.filter { $0 != d }
                                        for e in potentialSegments[.lowerRight]! {
                                            guard charsLeft.contains(e) else { continue }
                                            charsLeft = charsLeft.filter { $0 != e }
                                            for f in potentialSegments[.bottom]! {
                                                guard charsLeft.contains(f) else { continue }
                                                var tempDict: [SegmentType: [Character]] = [:]
                                                tempDict[.top] = [a]
                                                tempDict[.upperLeft] = [b]
                                                tempDict[.middle] = [c]
                                                tempDict[.upperRight] = [d]
                                                tempDict[.lowerRight] = [e]
                                                tempDict[.bottom] = [f]

                                                tempDict[.lowerLeft] = possibleCharacters
                                                    .filter { $0 != a }
                                                    .filter { $0 != b }
                                                    .filter { $0 != c }
                                                    .filter { $0 != d }
                                                    .filter { $0 != e }
                                                    .filter { $0 != f }

                                                workingChars.append(tempDict)
                                            }

                                            charsLeft.append(e)
                                        }

                                        charsLeft.append(d)
                                    }

                                    charsLeft.append(c)
                                }

                                charsLeft.append(b)
                            }

                            charsLeft.append(a)
                        }
                    }

                    // 6
                    if !filterVals(potentialSegments, from: .top, vals: chars).isEmpty &&
                        !filterVals(potentialSegments, from: .upperLeft, vals: chars).isEmpty &&
                        !filterVals(potentialSegments, from: .lowerLeft, vals: chars).isEmpty &&
                        !filterVals(potentialSegments, from: .bottom, vals: chars).isEmpty &&
                        !filterVals(potentialSegments, from: .lowerRight, vals: chars).isEmpty &&
                        !filterVals(potentialSegments, from: .middle, vals: chars).isEmpty {

                        var charsLeft = chars

                        for a in potentialSegments[.top]! {
                            charsLeft = charsLeft.filter { $0 != a }
                            for b in potentialSegments[.upperLeft]! {
                                guard charsLeft.contains(b) else { continue }
                                charsLeft = charsLeft.filter { $0 != b }
                                for c in potentialSegments[.lowerLeft]! {
                                    guard charsLeft.contains(c) else { continue }
                                    charsLeft = charsLeft.filter { $0 != c }
                                    for d in potentialSegments[.bottom]! {
                                        guard charsLeft.contains(d) else { continue }
                                        charsLeft = charsLeft.filter { $0 != d }
                                        for e in potentialSegments[.lowerRight]! {
                                            guard charsLeft.contains(e) else { continue }
                                            charsLeft = charsLeft.filter { $0 != e }
                                            for f in potentialSegments[.middle]! {
                                                guard charsLeft.contains(f) else { continue }
                                                var tempDict: [SegmentType: [Character]] = [:]
                                                tempDict[.top] = [a]
                                                tempDict[.upperLeft] = [b]
                                                tempDict[.lowerLeft] = [c]
                                                tempDict[.bottom] = [d]
                                                tempDict[.lowerRight] = [e]
                                                tempDict[.middle] = [f]

                                                tempDict[.upperRight] = possibleCharacters
                                                    .filter { $0 != a }
                                                    .filter { $0 != b }
                                                    .filter { $0 != c }
                                                    .filter { $0 != d }
                                                    .filter { $0 != e }
                                                    .filter { $0 != f }

                                                workingChars.append(tempDict)
                                            }

                                            charsLeft.append(e)
                                        }

                                        charsLeft.append(d)
                                    }

                                    charsLeft.append(c)
                                }

                                charsLeft.append(b)
                            }

                            charsLeft.append(a)
                        }
                    }
                }
            }

            var finalDisplay: SevenSegmentDisplay?
            while workingChars.count > 2 {
                let charSet = workingChars[1]
                let solvedDisplay = SevenSegmentDisplay(
                    upperLeft: charSet[.upperLeft]!.first!,
                    top: charSet[.top]!.first!,
                    upperRight: charSet[.upperRight]!.first!,
                    middle: charSet[.middle]!.first!,
                    lowerLeft: charSet[.lowerLeft]!.first!,
                    bottom: charSet[.bottom]!.first!,
                    lowerRight: charSet[.lowerRight]!.first!
                )

                var gotAll = false
                var remainingNums = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                for val in knownVals + unknownVals {
                    let convertedValue = solvedDisplay.getValue(of: val)
                    remainingNums.removeAll { $0 == convertedValue }
                }

                gotAll = remainingNums.isEmpty

                if !gotAll {
                    workingChars.remove(at: 1)
                } else {
                    finalDisplay = solvedDisplay
                    break
                }
            }

            var finalOutputStr = ""
            for output in entry.outputs {
                finalOutputStr += "\(finalDisplay!.getValue(of: output))"
            }

            outputs.append(Int(finalOutputStr)!)
        }

        answer = "\(outputs.reduce(0, +))"
    }

    private func filterVals(_ dict: [SegmentType: [Character]], from type: SegmentType, vals: [Character]) -> [Character] {
        let currVals = dict[type]!
        return currVals
            .filter { vals.contains($0) }
    }

    private func removeVals(_ dict: [SegmentType: [Character]], from type: SegmentType, vals: [Character]) -> [Character] {
        let currVals = dict[type]!
        return currVals
            .filter { !vals.contains($0) }
    }

    private func initPotentialSegmentsDict() -> [SegmentType: [Character]] {
        [
            .upperLeft: ["a", "b", "c", "d", "e", "f", "g"],
            .top: ["a", "b", "c", "d", "e", "f", "g"],
            .upperRight: ["a", "b", "c", "d", "e", "f", "g"],
            .middle: ["a", "b", "c", "d", "e", "f", "g"],
            .lowerRight: ["a", "b", "c", "d", "e", "f", "g"],
            .bottom: ["a", "b", "c", "d", "e", "f", "g"],
            .lowerLeft: ["a", "b", "c", "d", "e", "f", "g"]
        ]
    }

    private func isEasyDigit(_ str: String) -> Bool {
        return str.isOne || str.isFour || str.isSeven || str.isEight
    }

    private func parseInput() -> [Entry] {
        var entries: [Entry] = []
        let lines = Utils.readFile("day8_input")
        for line in lines {
            let inputAndOutput = line.split(separator: "|")
            let input = inputAndOutput[0].split(whereSeparator: \.isWhitespace)
                .map { $0.trimmingCharacters(in: .whitespaces) }

            let output = inputAndOutput[1].split(separator: " ")
                .map { $0.trimmingCharacters(in: .whitespaces) }

            entries.append(Entry(inputs: input, outputs: output))
        }

        return entries
    }

    struct SevenSegmentDisplay {
        let upperLeft: Character
        let top: Character
        let upperRight: Character
        let middle: Character
        let lowerLeft: Character
        let bottom: Character
        let lowerRight: Character

        func getValue(of str: String) -> Int {
            if str.sorted() == [upperLeft, top, upperRight, lowerRight, bottom, lowerLeft].sorted() {
                return 0
            }

            if str.sorted() == [upperRight, lowerRight].sorted() {
                return 1
            }

            if str.sorted() == [top, upperRight, middle, lowerLeft, bottom].sorted() {
                return 2
            }

            if str.sorted() == [top, upperRight, middle, lowerRight, bottom].sorted() {
                return 3
            }

            if str.sorted() == [upperLeft, middle, upperRight, lowerRight].sorted() {
                return 4
            }

            if str.sorted() == [top, upperLeft, middle, lowerRight, bottom].sorted() {
                return 5
            }

            if str.sorted() == [top, upperLeft, middle, lowerLeft, bottom, lowerRight].sorted() {
                return 6
            }

            if str.sorted() == [top, upperRight, lowerRight].sorted() {
                return 7
            }

            if str.sorted() == [upperLeft, top, upperRight, middle, lowerLeft, bottom, lowerRight].sorted() {
                return 8
            }

            return 9
        }
    }

    enum SegmentType {
        case upperLeft
        case top
        case upperRight
        case middle
        case lowerLeft
        case bottom
        case lowerRight
    }

    struct Entry {
        let inputs: [String]
        let outputs: [String]
    }
}

extension String {
    var isOne: Bool {
        self.count == 2
    }

    var isFour: Bool {
        self.count == 4
    }

    var isSeven: Bool {
        self.count == 3
    }

    var isEight: Bool {
        self.count == 7
    }
}
