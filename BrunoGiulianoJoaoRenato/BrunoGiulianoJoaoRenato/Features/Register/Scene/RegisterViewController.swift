//
//  RegisterViewController.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

protocol RegisterViewControllerDisplayble: AnyObject {
    func fetchStates(viewModels: [String])
    func getProduct(viewModel: ProductSavedViewModel)
    func completedRegister(state: RegisterViewModel.Finished)
}

final class RegisterViewController: UIViewController {
    private let viewModel: RegisterViewModelLogic
    private let contentView: RegisterViewProtocol
    private let product: Product?

    init(
        viewModel: RegisterViewModelLogic,
        contentView: RegisterViewProtocol,
        product: Product?
    ) {
        self.viewModel = viewModel
        self.contentView = contentView
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        if let product {
            viewModel.updateProduct(product)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchStates()
        contentView.reload()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.view.endEditing(true)
    }
}

extension RegisterViewController: RegisterViewDelegate {
    func didTapEdit(name: String?, value: Double?, isCard: Bool, image: Data?, state: String?) {
        if let product {
            viewModel.editProduct(product: product, name ?? String(), value ?? Double(), isCard, image, state ?? String())
        }
        navigationController?.popViewController(animated: true)
    }
    
    func didTapRegister(name: String?, value: Double?, isCard: Bool, image: Data?, state: String?) {
        viewModel.saveProduct(name: name ?? String(), value: value ?? Double(), isCard: isCard, image: image, state: state ?? String())
    }

    func didTapImage() {
        ImagePickerAlertController().showAlert(on: self)
    }

    func didTapAdd() {
        self.navigationController?.pushViewController(AdjustFactory.make(), animated: true)
    }
}

extension RegisterViewController: RegisterViewControllerDisplayble {
    func completedRegister(state: RegisterViewModel.Finished) {
        switch state {
        case .success:
            navigationController?.popViewController(animated: true)
        case .error:
            let alert = UIAlertController(title: Strings.RegisterViewController.title,
                                          message: Strings.RegisterViewController.message,
                                          preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: Strings.RegisterViewController.button, style: .cancel)
            alert.addAction(cancelAction)

            present(alert, animated: true)
        }
    }

    func getProduct(viewModel: ProductSavedViewModel) {
        contentView.updateProduct(viewModel)
    }
    
    func fetchStates(viewModels: [String]) {
        contentView.fetchStates(viewModels: viewModels)
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage {
            contentView.setImage(image)
            dismiss(animated: true)
        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
