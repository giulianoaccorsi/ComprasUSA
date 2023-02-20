//
//  TotalConverter.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 19/02/23.
//

import Foundation

protocol TotalConvertable {
    func convert(_ product: Product) -> TotalProductViewModel
    func convert(_ products: [Product]) -> [TotalProductViewModel]
}

struct TotalConverter: TotalConvertable {
    func convert(_ product: Product) -> TotalProductViewModel {
        return TotalProductViewModel(
            value: product.value,
            card: product.isCard,
            stateIOF: product.state?.tax ?? 0.0
        )
    }

    func convert(_ products: [Product]) -> [TotalProductViewModel] {
        products.map {
            convert($0)
        }
    }
}
