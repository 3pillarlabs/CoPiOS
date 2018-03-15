//: [Previous](@previous)

import Foundation

let highwaySpeedLimit = Measurement<UnitSpeed>(value: 130, unit: .knots)
let formatter = MeasurementFormatter()
formatter.unitOptions = .naturalScale
//formatter.unitOptions = .providedUnit
print(formatter.string(from: highwaySpeedLimit))

//: [Next](@next)
