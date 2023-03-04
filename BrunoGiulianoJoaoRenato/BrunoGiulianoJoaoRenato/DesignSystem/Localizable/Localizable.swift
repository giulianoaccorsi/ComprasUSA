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
    enum TabBar {
        @Localizable static var list = "TabBar.List"
        @Localizable static var adjust = "TabBar.Adjust"
        @Localizable static var total = "TabBar.Total"
    }

    enum EmptyStateView {
        @Localizable static var text = "EmptyStateView.Text"
    }

    enum RegisterViewController {
        @Localizable static var title = "RegisterViewController.Title"
        @Localizable static var message = "RegisterViewController.Message"
        @Localizable static var button = "RegisterViewController.Button"
    }

    enum RegisterView {
        @Localizable static var name = "RegisterView.PlaceholderNameProduct"
        @Localizable static var state = "RegisterView.PlaceholderStateProduct"
        @Localizable static var value = "RegisterView.PlaceholderValueProduct"
        @Localizable static var buttonRegister = "RegisterView.Button.Register"
        @Localizable static var buttonEdit = "RegisterView.Button.Edit"
        @Localizable static var card = "RegisterView.Switch.Card"
    }

    enum ImagePickerAlert {
        @Localizable static var photo = "ImagePickerAlert.photoTitle"
        @Localizable static var camera = "ImagePickerAlert.cameraTitle"
        @Localizable static var cancel = "ImagePickerAlert.cancelButton"
    }

    enum AdjustView {
        @Localizable static var quotation = "AdjustView.Quotation"
        @Localizable static var iof = "AdjustView.IOF"
        @Localizable static var labelTax = "AdjustView.LabelTax"
        @Localizable static var button = "AdjustView.ButtonState"
    }

    enum AlertState {
        @Localizable static var titleAdd = "AlertState.Title.Add"
        @Localizable static var titleEdit = "AlertState.Title.Edit"
        @Localizable static var state = "AlertState.Textfield.State"
        @Localizable static var tax = "AlertState.Textfield.Tax"
        @Localizable static var addButton = "AlertState.Button.Add"
        @Localizable static var cancelButton = "AlertState.Button.Cancel"
    }

    enum TotalView {
        @Localizable static var dollar = "TotalView.Dollar.Title"
        @Localizable static var real = "TotalView.Real.Title"
    }
}
