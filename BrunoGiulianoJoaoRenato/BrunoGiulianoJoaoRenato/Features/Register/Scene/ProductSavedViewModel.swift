//
//  ProductSavedViewModel.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 19/02/23.
//

import Foundation

struct ProductSavedViewModel: Equatable {
    let name: String
    let value: Double
    let isCard: Bool
    let image: Data?
    let state: State?
}
