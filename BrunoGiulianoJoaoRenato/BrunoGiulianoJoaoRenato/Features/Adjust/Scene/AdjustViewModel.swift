//
//  AdjustViewModel.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import Foundation
enum TypeTextfield {
    case iof
    case quotation
}

protocol AdjustViewModelLogic {
    func fetchStates()
    func addState(viewModel: StateCellViewModel)
    func getState(index: Int)
    func tapToEditViewModel(viewModel: StateCellViewModel)
    func swipedToDelete(index: Int)
    func fetchConfiguration()
    func save(type: TypeTextfield, text: String)
}

final class AdjustViewModel {
    private(set) var states: [State] = []
    weak var display: AdjustViewControllerDisplayble?

    private let repository: StateService
    private let converter: AdjustConvertable
    private let userDefault = UserDefaults.standard

    init(repository: StateService, converter: AdjustConvertable) {
        self.repository = repository
        self.converter = converter
    }

    private func setupStatesToDisplay(states: [State]) {
        self.states = states
        display?.displayStates(converter.convert(states))
    }
}

extension AdjustViewModel: AdjustViewModelLogic {
    func save(type: TypeTextfield, text: String) {
        switch type {
        case .iof:
            userDefault.set(text, forKey: "iof_preference")
        case .quotation:
            userDefault.set(text, forKey: "dollar_preference")
        }
    }

    func fetchConfiguration() {
        if let iof = userDefault.string(forKey: "iof_preference"),
           let quotation = userDefault.string(forKey: "dollar_preference") {
            display?.displayConfiguration((quotation, iof))
        }
    }

    func getState(index: Int) {
        if let state = repository.getState(id: states[index].objectID) {
            display?.displayState(converter.convert(state))
        }
    }

    func tapToEditViewModel(viewModel: StateCellViewModel) {
        if let id = viewModel.objectID {
            let state = repository.editState(id: id, newName: viewModel.name, newTax: viewModel.tax.toDouble())
            setupStatesToDisplay(states: state)
        }
    }

    func addState(viewModel: StateCellViewModel) {
        let states = repository.saveState(name: viewModel.name, tax: viewModel.tax.toDouble())
        setupStatesToDisplay(states: states)
    }

    func fetchStates() {
        self.setupStatesToDisplay(states: self.repository.loadStates())
    }

    func swipedToDelete(index: Int) {
        let states = repository.deleteState(id: states[index].objectID)
        self.setupStatesToDisplay(states: states)
    }
}
