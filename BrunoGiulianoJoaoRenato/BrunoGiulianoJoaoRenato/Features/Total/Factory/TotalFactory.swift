//
//  TotalFactory.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 19/02/23.
//

enum TotalFactory {
    static func make() -> TotalViewController {
        let viewModel = TotalViewModel(repository: ProductService(), converter: TotalConverter())
        let viewController = TotalViewController(viewModel: viewModel, contentView: TotalView())
        viewModel.display = viewController

        return viewController
    }
}
