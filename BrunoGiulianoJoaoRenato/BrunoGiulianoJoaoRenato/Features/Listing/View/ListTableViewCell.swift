//
//  ListTableViewCell.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit
import CoreData

struct ProductViewModel: Equatable {
    let id: NSManagedObjectID
    let name: String
    let image: UIImage?
    let value: String
}

final class MatchTableViewCell: UITableViewCell, Reusable {
    private let imageViewProduct: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 18
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true

        return image
    }()

    private let labelNameProduct: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .left

        return label
    }()

    private let labelPrice: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textAlignment = .left

        return label
    }()


    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelNameProduct, labelPrice])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
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
        guard let viewModel = viewModel as? ProductViewModel else { return }

        labelNameProduct.text = viewModel.name
        labelPrice.text = viewModel.value
        imageViewProduct.image = viewModel.image
    }

    private func setupConstraints() {
        contentView.addSubview(imageViewProduct, constraints: [
            imageViewProduct.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageViewProduct.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageViewProduct.heightAnchor.constraint(equalToConstant: 100),
            imageViewProduct.widthAnchor.constraint(equalToConstant: 100),
            imageViewProduct.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])

        contentView.addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: imageViewProduct.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: imageViewProduct.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }

    private func setupLayout() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
}
