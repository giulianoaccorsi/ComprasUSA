//
//  SceneDelegate.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let quotation = ["dollar_preference": "3.2"]
        UserDefaults.standard.register(defaults: quotation)
        let iof = ["iof_preference": "6.38"]
        UserDefaults.standard.register(defaults: iof)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewController = TabBar()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

