//
//  TabBarController.swift
//  TelkomselApp
//
//  Created by Amin faruq on 11/11/22.
//

import UIKit
import TelkomselModule

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: ViewController(), title: NSLocalizedString("My Feed", comment: ""), image: UIImage(systemName: "house")!),
            
            createNavController(for: ViewController(), title: NSLocalizedString("My Product", comment: ""), image: UIImage(systemName: "person")!)
        ]
    }
}

extension TabBarController {
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }
}

