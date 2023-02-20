//
//  AdjustFactory.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 18/02/23.
//

enum AdjustFactory {
    static func make() -> AdjustViewController {
        let viewModel = AdjustViewModel(repository: StateService(), converter: AdjustConverter())
        let viewController = AdjustViewController(viewModel: viewModel, contentView: AdjustView())
        viewModel.display = viewController

        return viewController
    }
}

