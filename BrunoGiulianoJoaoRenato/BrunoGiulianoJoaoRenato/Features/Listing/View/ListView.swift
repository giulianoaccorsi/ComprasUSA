//
//  ListView.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//
import UIKit

protocol ListViewProtocol: UIView {
    var delegate: ListViewDelegate? { get set }
    func changeState(_ state: ListView.State)
}

protocol ListViewDelegate: AnyObject {
    func listViewDidSelectMatch(index: Int)
    func listViewDidSwippedToDelete(index: Int)
}

final class ListView: UIView {
    enum State {
        case content(viewModels: [ProductViewModel])
        case empty
    }

    private lazy var tableViewProvider = TableViewProvider<MatchTableViewCell, ProductViewModel>(tableView: tableView, delegate: self)

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground

        return tableView
    }()

    private let emptyStateView = EmptyStateView(message: Strings.EmptyStateView.text)

    weak var delegate: ListViewDelegate?

    init() {
        super.init(frame: .zero)

        setupConstraints()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(tableView, constraints: [
            tableView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(emptyStateView, constraints: [
            emptyStateView.topAnchor.constraint(equalTo: topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupLayout() {
        backgroundColor = .systemBackground
    }
}

extension ListView: ListViewProtocol {
    func changeState(_ state: State) {
        switch state {
        case .content(viewModels: let viewModels):
            tableViewProvider.viewModels = viewModels
            tableView.isHidden = false
            emptyStateView.isHidden = true
        case .empty:
            tableView.isHidden = true
            emptyStateView.isHidden = false
        }
    }
}

extension ListView: TableViewProviderDelegate {
    func tableViewProviderDidSelectCell(index: Int) {
        delegate?.listViewDidSelectMatch(index: index)
    }

    func tableViewProviderDidSwipedToDelete(index: Int) {
        delegate?.listViewDidSwippedToDelete(index: index)
    }
    
}
