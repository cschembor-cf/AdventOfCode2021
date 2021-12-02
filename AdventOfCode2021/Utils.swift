//
//  Utils.swift
//  AdventOfCode2021
//
//  Created by Connor Schembor on 12/1/21.
//

import Foundation

class Utils {

    class func readFile(_ name: String) -> [String.SubSequence] {
        let path = Bundle.main.path(forResource: "input", ofType: "txt")
        let fileContents = try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        return fileContents.split(whereSeparator: \.isNewline)
    }
}

