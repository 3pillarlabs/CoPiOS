//: [Previous](@previous)

import Foundation

let timisoaraToCluj = Measurement<UnitLength>(value: 320.0, unit: .kilometers)
let tripDuration = Measurement<UnitDuration>(value: 5.0, unit: .hours)
let averageSpeed = timisoaraToCluj / tripDuration
print("European citizen are using the speed as \(averageSpeed.converted(to: .kilometersPerHour))")
print("Average speed for US citizen would be \(averageSpeed.converted(to: .milesPerHour))")

//: [Next](@next)
