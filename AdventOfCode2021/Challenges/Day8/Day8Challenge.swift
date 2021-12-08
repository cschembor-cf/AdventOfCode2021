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
