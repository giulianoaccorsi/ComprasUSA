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
                    title: Strings.TabBar.list, image: carImage
                ),

                createNavController(
                    for: AdjustFactory.make(),
                    title: Strings.TabBar.adjust, image: systemImage
                ),

                createNavController(
                    for: TotalFactory.make(),
                    title: Strings.TabBar.total, image: bag
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
