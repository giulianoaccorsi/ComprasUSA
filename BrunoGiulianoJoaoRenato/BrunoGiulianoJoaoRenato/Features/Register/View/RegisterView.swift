//
//  RegisterView.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

protocol RegisterViewProtocol: UIView {
    var delegate: RegisterViewDelegate? { get set }
    func setImage(_ image: UIImage)
    func updateProduct(_ product: ProductSavedViewModel)
    func fetchStates(viewModels: [String])
    func reload()
}

protocol RegisterViewDelegate: AnyObject {
    func didTapRegister(name: String?, value: Double?, isCard: Bool, image: Data?, state: String?)
    func didTapEdit(name: String?, value: Double?, isCard: Bool, image: Data?, state: String?)
    func didTapAdd()
    func didTapImage()
}

final class RegisterView: UIView {
    private var isEditing: Bool = false

    private lazy var textFieldProduct: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Strings.RegisterView.name
        textfield.borderStyle = .roundedRect

        return textfield
    }()

    private lazy var imageProduct: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 3
        image.image = UIImage.placeholderProduct
        image.isUserInteractionEnabled = true
        image.clipsToBounds = true

        return image
    }()

    private lazy var textFieldState: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Strings.RegisterView.state
        textfield.borderStyle = .roundedRect
        textfield.addTarget(self, action: #selector(textFieldTapped), for: .touchDown)

        return textfield
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.addTarget(self, action: #selector(didTappedAdd), for: .touchUpInside)

        return button
    }()

    private lazy var stackState: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textFieldState, addButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fill

        return stackView
    }()

    private lazy var labelCard: UILabel = {
        let label = UILabel()
        label.text = Strings.RegisterView.card
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var switchCard: UISwitch = {
        let switchCard = UISwitch()
        switchCard.translatesAutoresizingMaskIntoConstraints = false

        return switchCard
    }()

    private lazy var textfieldValue: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = Strings.RegisterView.value
        textfield.borderStyle = .roundedRect
        textfield.keyboardType = .decimalPad
        textfield.translatesAutoresizingMaskIntoConstraints = false

        return textfield
    }()

    private lazy var stackViewSwitch: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelCard, switchCard])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.distribution = .fillEqually

        return stackView
    }()

    private lazy var stackValue: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textfieldValue, stackViewSwitch])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fill

        return stackView
    }()

    private lazy var registerProductButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.RegisterView.buttonRegister, for: .normal)
        button.addTarget(self, action: #selector(didTappedRegister), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.backgroundColor = UIColor(red: 0.0, green: 0.384, blue: 1.0, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var pickerView = UIPickerView()
    private lazy var pickerViewProvider = PickerViewProvider(pickerView: pickerView, delegate: self)
    weak var delegate: RegisterViewDelegate?

    init() {
        super.init(frame: .zero)

        setupConstraints()
        setupLayout()
        setUpAdditionalConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(textFieldProduct, constraints: [
            textFieldProduct.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            textFieldProduct.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textFieldProduct.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        addSubview(imageProduct, constraints: [
            imageProduct.topAnchor.constraint(equalTo: textFieldProduct.bottomAnchor, constant: 8),
            imageProduct.leadingAnchor.constraint(equalTo: textFieldProduct.leadingAnchor),
            imageProduct.trailingAnchor.constraint(equalTo: textFieldProduct.trailingAnchor),
            imageProduct.heightAnchor.constraint(equalToConstant: 150)
        ])

        addSubview(stackState, constraints: [
            stackState.topAnchor.constraint(equalTo: imageProduct.bottomAnchor, constant: 8),
            stackState.leadingAnchor.constraint(equalTo: textFieldProduct.leadingAnchor),
            stackState.trailingAnchor.constraint(equalTo: textFieldProduct.trailingAnchor),
            stackState.heightAnchor.constraint(equalToConstant: 34)
        ])

        addSubview(stackValue, constraints: [
            stackValue.topAnchor.constraint(equalTo: stackState.bottomAnchor, constant: 8),
            stackValue.leadingAnchor.constraint(equalTo: textFieldProduct.leadingAnchor),
            stackValue.trailingAnchor.constraint(equalTo: textFieldProduct.trailingAnchor),
            stackValue.heightAnchor.constraint(equalToConstant: 34),
        ])

        addSubview(registerProductButton, constraints: [
            registerProductButton.topAnchor.constraint(equalTo: stackValue.bottomAnchor, constant: 8),
            registerProductButton.leadingAnchor.constraint(equalTo: textFieldProduct.leadingAnchor),
            registerProductButton.trailingAnchor.constraint(equalTo: textFieldProduct.trailingAnchor),
            registerProductButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    private func setupLayout() {
        backgroundColor = .systemBackground
    }

    private func setUpAdditionalConfiguration() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedImage))
        imageProduct.addGestureRecognizer(tapRecognizer)
    }

    private func isPlaceholderImage() -> Bool {
        guard let image = imageProduct.image else {
                return false
            }
            return image == UIImage.placeholderProduct
    }

    @objc func didTappedRegister() {

        if isEditing {
            delegate?.didTapEdit(
                name: textFieldProduct.text,
                value: textfieldValue.text?.toDouble(),
                isCard: switchCard.isOn,
                image: isPlaceholderImage() ? nil : imageProduct.image?.jpegData(compressionQuality: 0.8),
                state: textFieldState.text
            )
            return
        }
        delegate?.didTapRegister(
            name: textFieldProduct.text,
            value: textfieldValue.text?.toDouble(),
            isCard: switchCard.isOn,
            image: isPlaceholderImage() ? nil : imageProduct.image?.jpegData(compressionQuality: 0.8),
            state: textFieldState.text
        )
    }

    @objc func didTappedAdd() {
        delegate?.didTapAdd()
    }

    @objc func textFieldTapped() {
        if pickerViewProvider.viewModels.count > 0 {
            textFieldState.inputView = pickerView
        }else {
            textFieldState.inputView = UIView()
        }
    }

    @objc private func tappedImage() {
        delegate?.didTapImage()
    }

    func reload() {
        textFieldState.reloadInputViews()
    }
}

extension RegisterView: PickerViewProviderDelegate {
    func pickerViewProviderDidSelect(index: Int) {
        textFieldState.text = pickerViewProvider.viewModels[index]
    }
}

extension RegisterView: RegisterViewProtocol {
    func updateProduct(_ product: ProductSavedViewModel) {
        if let image = product.image {
            isEditing = true
            registerProductButton.setTitle(Strings.RegisterView.buttonEdit, for: .normal)
            textFieldProduct.text = product.name
            textfieldValue.text = "\(product.value)"
            textFieldState.text = "\(product.state?.name ?? String())"
            imageProduct.image = UIImage(data: image)
            switchCard.isOn = product.isCard
        }
    }
    
    func fetchStates(viewModels: [String]) {
        pickerViewProvider.viewModels = viewModels
    }

    func setImage(_ image: UIImage) {
        self.imageProduct.image = image
    }
}
