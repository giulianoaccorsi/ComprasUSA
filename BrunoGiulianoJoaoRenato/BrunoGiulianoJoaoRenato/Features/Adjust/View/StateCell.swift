//
//  StateCell.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 18/02/23.
//

import UIKit
import CoreData

struct StateCellViewModel: Equatable {
    let name: String
    let tax: String
    var objectID: NSManagedObjectID?
}

final class StateCell: UITableViewCell, Reusable {
    private lazy var labelStateName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left

        return label
    }()

    private lazy var labelStateTax: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .right

        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStateName, labelStateTax])
        stackView.spacing = 8
        stackView.distribution = .fill

        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupConstraints()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup<ViewModel>(_ viewModel: ViewModel) {
        guard let viewModel = viewModel as? StateCellViewModel else { return }
        labelStateName.text = viewModel.name
        labelStateTax.text = viewModel.tax
    }

    private func setupConstraints() {
        contentView.addSubview(stackView, constraints: [
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    private func setupLayout() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
}
