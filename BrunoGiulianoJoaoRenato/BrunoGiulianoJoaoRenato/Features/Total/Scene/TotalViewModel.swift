//
//  TotalViewModel.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//
import Foundation

struct TotalProductViewModel {
    let value: Double
    let card: Bool
    let stateIOF: Double
}

protocol TotalViewModelLogic {
    func fetchConfiguration()
}

final class TotalViewModel {
    weak var display: TotalViewControllerDisplayble?

    private let repository: ProductService
    private let converter: TotalConvertable
    private let userDefault = UserDefaults.standard

    init(repository: ProductService, converter: TotalConvertable) {
        self.repository = repository
        self.converter = converter
    }
}

extension TotalViewModel: TotalViewModelLogic {
    func fetchConfiguration() {
        let products = converter.convert(repository.loadProducts())
        let iof = userDefault.string(forKey: "iof_preference")?.toDouble()
        let quotation = userDefault.string(forKey: "dollar_preference")?.toDouble()
        let moneyTax = 0.011
        if let iof, let quotation {
            let real = products.reduce(0.0) {
                let percentageIOF = iof/100
                let localTax = $1.value * ($1.stateIOF/100)
                let tax = $1.card ? percentageIOF : moneyTax
                let valueWithQuotation = ($1.value + localTax) * quotation
                let valueWithTax = (valueWithQuotation * tax)
                let product = valueWithTax + valueWithQuotation
                return ($0 + product)
            }

            let dollar = products.reduce(0.0) {
                let percentageIOF = iof/100
                let localTax = $1.value * ($1.stateIOF/100)
                let tax = $1.card ? percentageIOF : moneyTax
                let valueWithQuotation = ($1.value + localTax)
                let valueWithTax = (valueWithQuotation * tax)
                let product = valueWithTax + valueWithQuotation
                return ($0 + product)
            }
            display?.displayConfiguration(
                MoneyViewModel(
                    dollar: "\(dollar)"
                        .convertValueToFormatedValue(
                        currencySymbol: "$"
                    ),
                    real: "\(real)"
                        .convertValueToFormatedValue(
                            currencySymbol: "R$"
                        )
                )
            )
        }
    }
}
