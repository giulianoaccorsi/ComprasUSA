//
//  ListConverter.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//
import UIKit
import CoreData

protocol ListConvertable {
    func convert(_ product: Product) -> ProductViewModel
    func convert(_ products: [Product]) -> [ProductViewModel]
}

struct ListConverter: ListConvertable {
    func convert(_ product: Product) -> ProductViewModel {
        return ProductViewModel(id: product.objectID,
                                name: product.name ?? String(),
                                image: product.photo != nil ? UIImage(data: product.photo ?? Data()) : UIImage(named: "gift"),
                                value: "\(product.value)".convertValueToFormatedValue())
    }
    
    func convert(_ products: [Product]) -> [ProductViewModel] {
        return products.map {
            convert($0)
        }
    }
}
