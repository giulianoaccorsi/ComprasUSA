//
//  PickerViewProvider.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 18/02/23.
//

import UIKit

protocol PickerViewProviderDelegate: AnyObject {
    func pickerViewProviderDidSelect(index: Int)
}

final class PickerViewProvider: NSObject, UIPickerViewDelegate, UIPickerViewDataSource  {
    var viewModels: [String] = [] {
        didSet {
            pickerView?.reloadAllComponents()
        }
    }

    private weak var pickerView: UIPickerView?
    private weak var delegate: PickerViewProviderDelegate?

    init(pickerView: UIPickerView, delegate: PickerViewProviderDelegate?) {
        self.pickerView = pickerView
        self.delegate = delegate
        super.init()

        setupPickerView()
    }

    private func setupPickerView() {
        pickerView?.delegate = self
        pickerView?.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModels.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModels[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerViewProviderDidSelect(index: row)
    }
}
