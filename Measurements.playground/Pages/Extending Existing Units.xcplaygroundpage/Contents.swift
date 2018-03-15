//: [Previous](@previous)

import Foundation

extension UnitEnergy {
    static let cubicMeter = UnitEnergy(symbol: "mc",
                                       converter: UnitConverterLinear(coefficient: 10_751.0 * 3_600_000.0))
}

let gasUtilityReading = Measurement<UnitEnergy>(value: 93.0, unit: .cubicMeter)
print(gasUtilityReading.converted(to: .kilowattHours))

//: [Next](@next)
