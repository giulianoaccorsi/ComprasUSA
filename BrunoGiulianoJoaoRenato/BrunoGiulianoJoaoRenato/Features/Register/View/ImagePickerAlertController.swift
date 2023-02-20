//
//  ImagePicker.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 18/02/23.
//

import UIKit

final class ImagePickerAlertController: NSObject {

    func showAlert(on viewController: UIViewController) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let selectPhotoAction = UIAlertAction(title: Strings.ImagePickerAlert.photo, style: .default) { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = viewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            viewController.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(selectPhotoAction)

        let takePhotoAction = UIAlertAction(title: Strings.ImagePickerAlert.camera, style: .default) { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = viewController as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            viewController.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(takePhotoAction)

        let cancelAction = UIAlertAction(title: Strings.ImagePickerAlert.cancel, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true, completion: nil)
    }
}
