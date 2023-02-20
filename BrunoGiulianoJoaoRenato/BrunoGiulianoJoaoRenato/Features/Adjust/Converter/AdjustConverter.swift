//
//  AdjustConverter.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 18/02/23.
//

import UIKit
import CoreData

protocol AdjustConvertable {
    func convert(_ state: State) -> StateCellViewModel
    func convert(_ states: [State]) -> [StateCellViewModel]
}

struct AdjustConverter: AdjustConvertable {
    func convert(_ state: State) -> StateCellViewModel {
        return StateCellViewModel(
            name: state.name ?? String(),
            tax: "\(state.tax)",
            objectID: state.objectID
        )
    }

    func convert(_ states: [State]) -> [StateCellViewModel] {
        return states.map {
            convert($0)
        }
    }
}
