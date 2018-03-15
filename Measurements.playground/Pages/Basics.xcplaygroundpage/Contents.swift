//: [Previous](@previous)

import Foundation

let anyUnit = Unit(symbol: "Unit's symbol")
let dimension = Dimension(symbol: "Dimensional symbol",
                          converter: UnitConverterLinear(coefficient: 1.0, constant: 0.0)) // uses b = 1.0 * a + 0.0

let oneMile = Measurement<UnitLength>(value: 1.0, unit: .miles) // associate value of 1.0 with a concrete 'dimension'
let volume = Measurement<UnitVolume>(value: 2.0, unit: .gallons)
print("1 mile = \(oneMile.converted(to: .meters))")

//: [Next](@next)
