//
//  RegisterConverter.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 18/02/23.
//

import UIKit
import CoreData

protocol RegisterConvertable {
    func convert(_ state: State) -> String
    func convert(_ states: [State]) -> [String]
    func convert(_ product: Product) -> ProductSavedViewModel
    func convert(_ products: [Product]) -> [ProductSavedViewModel]
}

struct RegisterConverter: RegisterConvertable {
    func convert(_ product: Product) -> ProductSavedViewModel {
        return ProductSavedViewModel(
            name: product.name ?? String(),
            value: product.value,
            isCard: product.isCard,
            image: product.photo,
            state: product.state
        )
    }

    func convert(_ products: [Product]) -> [ProductSavedViewModel] {
        return products.map {
            convert($0)
        }
    }

    func convert(_ state: State) -> String {
        return state.name ?? String()
    }

    func convert(_ states: [State]) -> [String] {
        return states.map {
            convert($0)
        }
    }
}
