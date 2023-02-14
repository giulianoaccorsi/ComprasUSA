//
//  ListViewController.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

protocol ListViewControllerDisplayble: AnyObject {
    func displayState(_ state: ListView.State)
    func displayProductDetail(productViewModel: ProductViewModel)
}

final class ListViewController: UIViewController {
    private let viewModel: ListViewModelLogic
    private let contentView: ListViewProtocol

    init(
        viewModel: ListViewModelLogic,
        contentView: ListViewProtocol
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

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchProducts()
    }
}

extension ListViewController: ListViewDelegate {
    func listViewDidSelectMatch(index: Int) {
        viewModel.selectProduct(index: index)
    }

    func listViewDidSwippedToDelete(index: Int) {
        viewModel.swipedToDelete(index: index)
    }
}

extension ListViewController: ListViewControllerDisplayble {
    func displayState(_ state: ListView.State) {
        DispatchQueue.main.async { [weak self] in
            self?.contentView.changeState(state)
        }
    }

    func displayProductDetail(productViewModel: ProductViewModel) {
        // Próxima Tela
    }
}
