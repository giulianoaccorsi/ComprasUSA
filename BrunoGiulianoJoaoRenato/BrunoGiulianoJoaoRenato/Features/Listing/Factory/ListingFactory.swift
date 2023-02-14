//
//  ListingFactory.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

enum ListingFactory {
    static func make() -> ListViewController {
        let viewModel = ListViewModel(repository: ProductService(), converter: ListConverter())
        let viewController = ListViewController(viewModel: viewModel, contentView: ListView())
        viewModel.display = viewController

        return viewController
    }
}

