//: [Previous](@previous)

import Foundation

// Computes equation y = coef * value * base ^ exponent
class UnitExponentialConverter: UnitConverter {
    let coefficient: Double
    let base: Double
    let exponent: Double

    init(coefficient: Double = 1.0, base: Double, exponent: Double) {
        self.coefficient = coefficient
        self.base = base
        self.exponent = exponent
    }

    override func baseUnitValue(fromValue value: Double) -> Double {
        return coefficient * value * pow(base, exponent)
    }

    override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
        let denominator = coefficient * pow(base, exponent)
        return baseUnitValue / denominator
    }
}

class Base2ExponentialConverter: UnitExponentialConverter {
    init(coefficient: Double = 1.0, exponent: Double) {
        super.init(coefficient: coefficient, base: 2, exponent: exponent)
    }
}

class Storage: Dimension {
    static let bit = Storage(symbol: "bit", converter: Base2ExponentialConverter(coefficient: 1.0 / 8.0, exponent: 0.0))
    static let byte = Storage(symbol: "byte", converter: Base2ExponentialConverter(exponent: 0))
    static let kb = Storage(symbol: "kb", converter: Base2ExponentialConverter(exponent: 10))
    static let mb = Storage(symbol: "mb", converter: Base2ExponentialConverter(exponent: 20))
    static let gb = Storage(symbol: "gb", converter: Base2ExponentialConverter(exponent: 30))
    static let tb = Storage(symbol: "tb", converter: Base2ExponentialConverter(exponent: 40))

    override class func baseUnit() -> Storage {
        return .byte
    }
}

let s = Measurement<Storage>(value: 4, unit: .gb)
print(s.converted(to: .byte))

//: [Next](@next)
