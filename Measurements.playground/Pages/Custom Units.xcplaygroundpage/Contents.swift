//: [Previous](@previous)

import Foundation

class UnitCurrency: Dimension {
    static let ron = UnitCurrency(symbol: "RON", converter: UnitConverterLinear(coefficient: 1.0))
    static let eur = UnitCurrency(symbol: "EUR", converter: UnitConverterLinear(coefficient: 4.7263))
    static let usd = UnitCurrency(symbol: "USD", converter: UnitConverterLinear(coefficient: 3.8405))
    static let aud = UnitCurrency(symbol: "AUD", converter: UnitConverterLinear(coefficient: 3.0249))
    static let gbp = UnitCurrency(symbol: "GBP", converter: UnitConverterLinear(coefficient: 5.3572))
    static let huf = UnitCurrency(symbol: "HUF", converter: UnitConverterLinear(coefficient: 0.0152))

    override class func baseUnit() -> UnitCurrency {
        return ron
    }
}

class UnitCalendar: Dimension {
    static let day = UnitCalendar(symbol: "day", converter: UnitConverterLinear(coefficient: 1.0))
    static let month = UnitCalendar(symbol: "month", converter: UnitConverterLinear(coefficient: 30.0))
    static let year = UnitCalendar(symbol: "year", converter: UnitConverterLinear(coefficient: 12.0 * 30.0))

    override class func baseUnit() -> UnitCalendar {
        return day
    }
}

class Loan: Dimension {
    static let montly = Loan(symbol: "RON/month", converter: UnitConverterLinear(coefficient: 1.0))

    override class func baseUnit() -> Loan {
        return montly
    }
}

let romanianHouse = Measurement<UnitCurrency>(value: 100_000.0, unit: .eur)
let bankLoan = romanianHouse.converted(to: .ron)
var loanDuration = Measurement<UnitCalendar>(value: 10, unit: .year)
loanDuration.convert(to: .month)
let loan = Measurement<Loan>(value: bankLoan.value / loanDuration.value, unit: .montly)

print(loan)

class GasUtility: Dimension {
    static let price = GasUtility(symbol: "RON", converter: UnitConverterLinear(coefficient: 100_000_000.0 / 12_713))
    static let kwh = GasUtility(symbol: "kwh", converter: UnitConverterLinear(coefficient: 1.0))
    static let cubicMeter = GasUtility(symbol: "mc", converter: UnitConverterLinear(coefficient: 10_751.0))

    override class func baseUnit() -> GasUtility {
        return kwh
    }
}

let gasUtilityReading = Measurement<GasUtility>(value: 400.0, unit: .cubicMeter)
print(gasUtilityReading.converted(to: .price))

//: [Next](@next)
