//
//  ListViewModel.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import Foundation

protocol ListViewModelLogic {
    func fetchProducts()
    func selectProduct(index: Int)
    func swipedToDelete(index: Int)
}

final class ListViewModel {
    private(set) var products: [Product] = []
    weak var display: ListViewControllerDisplayble?

    private let repository: ProductService
    private let converter: ListConvertable

    init(repository: ProductService, converter: ListConvertable) {
        self.repository = repository
        self.converter = converter
    }

    private func setupProductsToDisplay(products: [Product]) {
        self.products.append(contentsOf: products)
        self.products.count == 0 ? self.display?.displayState(.empty) : self.display?.displayState(.content(viewModels: self.converter.convert(products)))

    }
}

extension ListViewModel: ListViewModelLogic {
    func fetchProducts() {
        self.setupProductsToDisplay(products: repository.loadProducts())
    }

    func selectProduct(index: Int) {
        display?.displayProductDetail(productViewModel: converter.convert(products[index]))

    }

    func swipedToDelete(index: Int) {
        self.setupProductsToDisplay(products: repository.deleteProduct(id: products[index].objectID))
    }
}
