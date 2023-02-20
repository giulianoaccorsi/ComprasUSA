//
//  RegisterFactory.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 18/02/23.
//

enum RegisterFactory {
    static func make(product: Product?) -> RegisterViewController {

        let viewModel = RegisterViewModel(productRepository: ProductService(), stateRepository: StateService(), converter: RegisterConverter())
        let contentView = RegisterView()
        let viewController = RegisterViewController(viewModel: viewModel, contentView: contentView, product: product)
        viewModel.display = viewController

        return viewController
    }
}

