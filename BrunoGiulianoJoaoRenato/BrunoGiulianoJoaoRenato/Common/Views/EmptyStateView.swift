//
//  EmptyView.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

final class EmptyStateView: UIView {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "🤔"
        label.textAlignment = .center

        return label
    }()

    init(message: String) {
        super.init(frame: .zero)

        setupMessage(message)
        setupConstraints()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupMessage(_ message: String) {
        messageLabel.text = message
    }

    private func setupConstraints() {
        addSubview(messageLabel, constraints: [
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30)
        ])

        addSubview(emojiLabel, constraints: [
            emojiLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            emojiLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    private func setupLayout() {
        backgroundColor = .systemBackground
    }
}
