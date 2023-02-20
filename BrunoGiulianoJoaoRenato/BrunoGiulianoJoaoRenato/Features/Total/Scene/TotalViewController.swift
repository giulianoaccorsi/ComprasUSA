//
//  TotalViewController.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

protocol TotalViewControllerDisplayble: AnyObject {
    func displayConfiguration(_ total: MoneyViewModel)
}

final class TotalViewController: UIViewController {
    private let viewModel: TotalViewModelLogic
    private let contentView: TotalViewProtocol

    init(
        viewModel: TotalViewModelLogic,
        contentView: TotalViewProtocol
    ) {
        self.viewModel = viewModel
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchConfiguration()
    }
}

extension TotalViewController: TotalViewControllerDisplayble {
    func displayConfiguration(_ total: MoneyViewModel) {
        contentView.fetchShoppingValue(viewModel: total)
    }
}
