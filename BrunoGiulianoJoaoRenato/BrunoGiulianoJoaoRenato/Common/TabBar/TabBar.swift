//
//  TabBar.swift
//  BrunoGiulianoJoaoRenato
//
//  Created by Giuliano Accorsi on 14/02/23.
//

import UIKit

final class TabBar: UITabBarController {
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupViewControllers()
    }

    private func setupViewControllers() {
        if let carImage = UIImage(named: "car"),
           let systemImage = UIImage(systemName: "gearshape"),
           let bag = UIImage(named: "bag") {
            viewControllers = [
                createNavController(
                    for: ListingFactory.make(),
                    title: Strings.listTabBar, image: carImage
                ),

                createNavController(
                    for: AdjustViewController(),
                    title: Strings.adjustTabBar, image: systemImage
                ),

                createNavController(
                    for: TotalViewController(),
                    title: Strings.totalTabBar, image: bag
                )
            ]
        }
    }

    fileprivate func createNavController
    (
        for rootViewController: UIViewController,
        title: String,
        image: UIImage
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
}
