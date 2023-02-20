//
//  AlertState.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 18/02/23.
//

import UIKit

protocol AlertStateDelegate: AnyObject {
    func tappedAdd(viewModel: StateCellViewModel)
    func tappedEdit(viewModel: StateCellViewModel)
}

final class AlertState: UIAlertController {

    weak var delegate: AlertStateDelegate?

    func showAlert(_ viewModel: StateCellViewModel? = nil) -> UIAlertController {
        let actionSheet = UIAlertController(
            title: viewModel != nil ? Strings.AlertState.titleEdit : Strings.AlertState.titleAdd,
            message: nil,
            preferredStyle: .alert
        )
        actionSheet.addTextField { (textField) in
            textField.placeholder = Strings.AlertState.state
            textField.keyboardType = .alphabet
            if viewModel != nil {
                textField.text = viewModel?.name
            }
        }

        actionSheet.addTextField { (textField) in
            textField.placeholder = Strings.AlertState.tax
            textField.keyboardType = .decimalPad
            if viewModel != nil {
                textField.text = viewModel?.tax
            }
        }

        let cancelAction = UIAlertAction(title: Strings.AlertState.cancelButton,
                                         style: .cancel,
                                         handler: nil)
        let addAction = UIAlertAction(
            title: Strings.AlertState.addButton,
            style: .default
        ) { (action) in
            if let nameTextField = actionSheet.textFields?[0].text,
               let taxTextField = actionSheet.textFields?[1].text {
                if viewModel != nil {
                    self.delegate?.tappedEdit(
                        viewModel: StateCellViewModel(
                            name: nameTextField,
                            tax: taxTextField,
                            objectID: viewModel?.objectID
                        )
                    )
                    return
                }
                self.delegate?.tappedAdd(
                    viewModel: StateCellViewModel(
                        name: nameTextField,
                        tax: taxTextField
                    )
                )
            }
        }

        actionSheet.addAction(cancelAction)
        actionSheet.addAction(addAction)

        return actionSheet
    }
}
