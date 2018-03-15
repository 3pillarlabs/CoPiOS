import Foundation

public func / (_ lhs: Measurement<UnitLength>, _ rhs: Measurement<UnitDuration>) -> Measurement<UnitSpeed> {
    let distance = lhs.converted(to: .meters)
    let time = rhs.converted(to: .seconds)
    return Measurement<UnitSpeed>(value: distance.value / time.value, unit: .metersPerSecond)
}
