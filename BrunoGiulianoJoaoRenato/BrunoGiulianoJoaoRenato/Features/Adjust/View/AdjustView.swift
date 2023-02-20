//
//  AdjustView.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

protocol AdjustViewProtocol: UIView {
    var delegate: AdjustViewDelegate? { get set }
    func fetchStates(viewModels: [StateCellViewModel])
    func fetchConfiguration(configuration: (iof: String, quotation: String))
}

protocol AdjustViewDelegate: AnyObject {
    func tappedAddState()
    func textfieldIOF(text: String)
    func textfieldQuotation(text: String)
    func listViewDidSelectMatch(index: Int)
    func listViewDidSwippedToDelete(index: Int)
}

final class AdjustView: UIView {
    private lazy var labelQuotation: UILabel = {
        let label = UILabel()
        label.text = Strings.AdjustView.quotation
        label.textAlignment = .right

        return label
    }()

    private lazy var textFieldQuotation: UITextField = {
        let textfield = UITextField()
        textfield.textAlignment = .right
        textfield.delegate = self
        textfield.borderStyle = .roundedRect

        return textfield
    }()

    private lazy var labelIOF: UILabel = {
        let label = UILabel()
        label.text = Strings.AdjustView.iof
        label.textAlignment = .right

        return label
    }()

    private lazy var textFielIOF: UITextField = {
        let textfield = UITextField()
        textfield.textAlignment = .right
        textfield.borderStyle = .roundedRect
        textfield.delegate = self

        return textfield
    }()

    private lazy var stackViewQuotation: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelQuotation, textFieldQuotation])
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 8

        return stackView
    }()

    private lazy var stackViewIOF: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelIOF, textFielIOF])
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 8

        return stackView
    }()

    private let labelTaxState: UILabel = {
        let label = UILabel()
        label.text = Strings.AdjustView.labelTax
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)

        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()

        return tableView
    }()

    private lazy var buttonAddState: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.AdjustView.button, for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.addTarget(self, action: #selector(tappedAddState), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    weak var delegate: AdjustViewDelegate?
    private lazy var tableViewProvider = TableViewProvider<StateCell, StateCellViewModel>(tableView: tableView, delegate: self)

    init() {
        super.init(frame: .zero)

        setupConstraints()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(stackViewQuotation, constraints: [
            stackViewQuotation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackViewQuotation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackViewQuotation.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
        ])

        addSubview(stackViewIOF, constraints: [
            stackViewIOF.leadingAnchor.constraint(equalTo: stackViewQuotation.leadingAnchor),
            stackViewIOF.trailingAnchor.constraint(equalTo: stackViewQuotation.trailingAnchor),
            stackViewIOF.topAnchor.constraint(equalTo: stackViewQuotation.bottomAnchor, constant: 16),
        ])

        addSubview(labelTaxState, constraints: [
            labelTaxState.topAnchor.constraint(equalTo: stackViewIOF.bottomAnchor, constant: 8),
            labelTaxState.leadingAnchor.constraint(equalTo: stackViewQuotation.leadingAnchor),
            labelTaxState.trailingAnchor.constraint(equalTo: stackViewQuotation.trailingAnchor),
        ])

        addSubview(tableView, constraints: [
            tableView.leadingAnchor.constraint(equalTo: stackViewQuotation.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: stackViewQuotation.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: labelTaxState.bottomAnchor, constant: 8),
        ])

        addSubview(buttonAddState, constraints: [
            buttonAddState.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            buttonAddState.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            buttonAddState.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])

    }

    private func setupLayout() {
        backgroundColor = .systemBackground
    }

    @objc private func tappedAddState() {
        delegate?.tappedAddState()
    }
}

extension AdjustView: AdjustViewProtocol {
    func fetchConfiguration(configuration: (iof: String, quotation: String)) {
        textFielIOF.text = configuration.iof
        textFieldQuotation.text = configuration.quotation
    }

    func fetchStates(viewModels: [StateCellViewModel]) {
        tableViewProvider.viewModels = viewModels
    }
}

extension AdjustView: TableViewProviderDelegate {
    func tableViewProviderDidSelectCell(index: Int) {
        delegate?.listViewDidSelectMatch(index: index)
    }

    func tableViewProviderDidSwipedToDelete(index: Int) {
        delegate?.listViewDidSwippedToDelete(index: index)
    }
}

extension AdjustView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == textFielIOF {
            delegate?.textfieldIOF(text: textField.text ?? String())
        } else if textField == textFieldQuotation {
            delegate?.textfieldQuotation(text: textField.text ?? String())
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
