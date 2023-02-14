//
//  Localizable.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import Foundation

@propertyWrapper
struct Localizable {
    var wrappedValue: String {
        didSet {
            wrappedValue = NSLocalizedString(wrappedValue, comment: "")
        }
    }

    init(wrappedValue: String) {
        self.wrappedValue = NSLocalizedString(wrappedValue, comment: "")
    }
}

enum Strings {
    @Localizable static var listTabBar = "TabBar.List"
    @Localizable static var adjustTabBar = "TabBar.Adjust"
    @Localizable static var totalTabBar = "TabBar.Total"
}

