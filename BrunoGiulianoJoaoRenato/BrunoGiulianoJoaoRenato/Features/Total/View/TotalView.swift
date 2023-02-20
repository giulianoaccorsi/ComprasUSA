//
//  TotalView.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

struct MoneyViewModel {
    let dollar: String
    let real: String
}

protocol TotalViewProtocol: UIView {
    func fetchShoppingValue(viewModel: MoneyViewModel)
}

final class TotalView: UIView {
    private lazy var labelDollarTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        label.text = Strings.TotalView.dollar

        return label
    }()

    private lazy var labelDollarValue: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        return label
    }()

    private lazy var labelRealTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .thin)
        label.text = Strings.TotalView.real

        return label
    }()

    private lazy var labelRealValue: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        return label
    }()

    private lazy var stackViewDollar: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelDollarTitle, labelDollarValue])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8

        return stackView
    }()

    private lazy var stackViewReal: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelRealTitle, labelRealValue])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8

        return stackView
    }()

    init() {
        super.init(frame: .zero)

        setupConstraints()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(stackViewDollar, constraints: [
            stackViewDollar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackViewDollar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackViewDollar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
        ])

        addSubview(stackViewReal, constraints: [
            stackViewReal.leadingAnchor.constraint(equalTo: stackViewDollar.leadingAnchor),
            stackViewReal.trailingAnchor.constraint(equalTo: stackViewDollar.trailingAnchor),
            stackViewReal.topAnchor.constraint(equalTo: stackViewDollar.bottomAnchor, constant: 16),
        ])
    }

    private func setupLayout() {
        backgroundColor = .systemBackground
    }
}

extension TotalView: TotalViewProtocol {
    func fetchShoppingValue(viewModel: MoneyViewModel) {
        labelDollarValue.text = viewModel.dollar
        labelRealValue.text = viewModel.real
    }
}
