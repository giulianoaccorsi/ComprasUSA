//
//  AdjustViewController.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

protocol AdjustViewControllerDisplayble: AnyObject {
    func displayStates(_ states: [StateCellViewModel])
    func displayState(_ state: StateCellViewModel)
    func displayConfiguration(_ configuration: (quotation: String, iof: String))
}

final class AdjustViewController: UIViewController {
    private let viewModel: AdjustViewModelLogic
    private let contentView: AdjustViewProtocol
    private lazy var alertState = AlertState()
    private var index: Int?

    init(
        viewModel: AdjustViewModelLogic,
        contentView: AdjustViewProtocol
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
        alertState.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchStates()
        viewModel.fetchConfiguration()
    }
}

extension AdjustViewController: AdjustViewDelegate {
    func textfieldIOF(text: String) {
        viewModel.save(type: .iof, text: text)
    }

    func textfieldQuotation(text: String) {
        viewModel.save(type: .quotation, text: text)
    }

    func listViewDidSelectMatch(index: Int) {
        viewModel.getState(index: index)
        self.index = index
    }

    func listViewDidSwippedToDelete(index: Int) {
        viewModel.swipedToDelete(index: index)
    }

    func tappedAddState() {
        present(alertState.showAlert(), animated: true)
    }

}

extension AdjustViewController: AdjustViewControllerDisplayble {
    func displayConfiguration(_ configuration: (quotation: String, iof: String)) {
        contentView.fetchConfiguration(configuration: (configuration.iof, configuration.quotation))
    }

    func displayState(_ state: StateCellViewModel) {
        present(alertState.showAlert(state), animated: true)
    }

    func displayStates(_ states: [StateCellViewModel]) {
        contentView.fetchStates(viewModels: states)
    }
}

extension AdjustViewController: AlertStateDelegate {
    func tappedEdit(viewModel: StateCellViewModel) {
        self.viewModel.tapToEditViewModel(viewModel: viewModel)
    }

    func tappedAdd(viewModel: StateCellViewModel) {
        self.viewModel.addState(viewModel: viewModel)
    }
}
