//
//  String+Format.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import Foundation

extension String {
    func convertValueToFormatedValue() -> String {
        let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$"
            formatter.maximumFractionDigits = 2

            return formatter
        }()
        let number = NSDecimalNumber(string: self.removeOccurrences())
        return numberFormatter.string(from: number) ?? "$0.00"
    }

    func toDouble() -> Double {
        Double(self.removeOccurrences()) ?? 0.0
    }

    func removeOccurrences() -> String {
        let removedDolar = self.replacingOccurrences(of: "$", with: "")
        let removedSpaces = removedDolar.replacingOccurrences(of: " ", with: "")
        let inputNumber = removedSpaces.replacingOccurrences(of: ",", with: ".")

        return inputNumber
    }
}
