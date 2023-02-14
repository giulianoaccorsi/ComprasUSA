//
//  TableView.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

protocol TableViewProviderDelegate: AnyObject {
    func tableViewProviderDidSelectCell(index: Int)
    func tableViewProviderDidSwipedToDelete(index: Int)
}

final class TableViewProvider<TableViewCell: UITableViewCell, ViewModel>: NSObject, UITableViewDelegate, UITableViewDataSource where TableViewCell: Reusable {

    var viewModels: [ViewModel] = [] {
        didSet {
            tableView?.reloadData()
        }
    }

    private weak var tableView: UITableView?
    private weak var delegate: TableViewProviderDelegate?

    init(tableView: UITableView, delegate: TableViewProviderDelegate?) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()

        setupTableView()
    }

    private func setupTableView() {
        tableView?.registerReusableCell(TableViewCell.self)
        tableView?.showsVerticalScrollIndicator = false
        tableView?.separatorStyle = .none
        tableView?.delegate = self
        tableView?.dataSource = self
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableViewProviderDidSelectCell(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let matchTableViewCell: TableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let viewModel = viewModels[indexPath.row]
        matchTableViewCell.setup(viewModel)

        return matchTableViewCell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.tableViewProviderDidSwipedToDelete(index: indexPath.row)
        }
    }
}
