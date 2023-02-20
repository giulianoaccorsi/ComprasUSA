//
//  RegisterViewModel.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import Foundation
import CoreData

struct ProductRegisterViewModel {
    let name: String
    let value: Double
    let isCard: Bool
    let image: Data?
    let state: String
    let product: Product?
}

protocol RegisterViewModelLogic {
    func fetchStates()
    func saveProduct(name: String, value: Double, isCard: Bool, image: Data?, state: String)
    func editProduct(product: Product, _ name: String, _ value: Double, _ isCard: Bool, _ image: Data?, _ state: String)
    func updateProduct(_ product: Product)
}

final class RegisterViewModel {
    private(set) var states: [State] = []
    weak var display: RegisterViewControllerDisplayble?

    private let productRepository: ProductService
    private let stateRepository: StateService
    private let converter: RegisterConvertable

    init(productRepository: ProductService, stateRepository: StateService, converter: RegisterConvertable) {
        self.productRepository = productRepository
        self.stateRepository = stateRepository
        self.converter = converter
    }

    private func getState(_ name: String) -> State? {
        states.filter { $0.name == name }.first
    }
}

extension RegisterViewModel: RegisterViewModelLogic {
    func fetchStates() {
        states = stateRepository.loadStates()
        display?.fetchStates(viewModels: converter.convert(states))
    }

    func saveProduct(name: String, value: Double, isCard: Bool, image: Data?, state: String) {
        if let state = getState(state) {
            productRepository.saveProduct(name: name, value: value, isCard: isCard, image: image, state: state)
        }
    }

    func editProduct(product: Product, _ name: String, _ value: Double, _ isCard: Bool, _ image: Data?, _ state: String) {
        if let state = getState(state) {
            productRepository.editProduct(id: product.objectID, name: name, value: value, isCard: isCard, image: image, state: state)
        }
    }

    func updateProduct(_ product: Product) {
        display?.getProduct(viewModel: converter.convert(product))
    }
}
