//
//  main.swift
//  No rights reserved.
//

import Foundation
import RegexHelper

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    
    var bits = [(Int, Int)]()
    for _ in 0..<lines[0].count {
        bits.append((0, 0))
    }
    lines.forEach { line in
        let lineArray = Array(line)
        for i in 0 ..< lineArray.count {
            if lineArray[i] == "1" {
                bits[i] = (bits[i].0 + 1, bits[i].1)
            } else {
                bits[i] = (bits[i].0, bits[i].1 + 1)
            }
        }
    }
    var gammaRate = [String]()
    var epsilonRate = [String]()
    for bit in bits {
        if bit.0 > bit.1 {
            gammaRate.append("0")
            epsilonRate.append("1")
        } else {
            gammaRate.append("1")
            epsilonRate.append("0")
        }
    }
    let gamma = Int(gammaRate.joined(separator: ""), radix: 2)!
    let epsilon = Int(epsilonRate.joined(separator: ""), radix: 2)!
    let powerConsumption = gamma * epsilon
    print(powerConsumption)
}

func main2() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    
    var bits = [[Character]]()
    var resultingBits = [[Character]]()
    
    for i in 0..<lines.count {
        let lineArray = Array(lines[i])
        bits.append(lineArray)
    }
    
    resultingBits = bits
    
    for i in 0..<bits[0].count {
        resultingBits = applyBitCriteriaO(bit: i, bits: resultingBits)
        if resultingBits.count == 1 {
            break
        }
    }
    
    let oxygenRating = Int(resultingBits[0].map { String($0) }.joined(separator: ""), radix: 2)!
    
    resultingBits = bits

    for i in 0..<bits[0].count {
        resultingBits = applyBitCriteriaCO2(bit: i, bits: resultingBits)
        if resultingBits.count == 1 {
            break
        }
    }
    
    let co2Rating = Int(resultingBits[0].map { String($0) }.joined(separator: ""), radix: 2)!
    
    print(co2Rating * oxygenRating)
}

func applyBitCriteriaO(bit: Int, bits: [[Character]]) -> [[Character]] {
    var verticalBits = [Character]()
    
    for i in 0..<bits.count { verticalBits.append(bits[i][bit]) }
    
    let sum = verticalBits.map { Int(String($0))! }.reduce(0, +)
    if Float(sum) >= Float(bits.count) / 2 { // 1
        return bits.filter { $0[bit] == "1" }
    } else { // 0
        return bits.filter { $0[bit] == "0" }
    }
}

func applyBitCriteriaCO2(bit: Int, bits: [[Character]]) -> [[Character]] {
    var verticalBits = [Character]()
    
    for i in 0..<bits.count { verticalBits.append(bits[i][bit]) }
    
    let sum = verticalBits.map { Int(String($0))! }.reduce(0, +)
    if Float(sum) >= Float(bits.count) / 2 { // 1
        return bits.filter { $0[bit] == "0" }
    } else { // 0
        return bits.filter { $0[bit] == "1" }
    }
}

//main()
main2()
