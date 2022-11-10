//
//  SceneDelegate.swift
//  TelkomselApp
//
//  Created by Amin faruq on 11/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        let home = TabBarController()
        window?.rootViewController = home
        window?.makeKeyAndVisible()
    }
   
}

