//
//  SceneDelegate.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 28/10/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let status = UserDefaults.standard.bool(forKey: "isLoggedIn")
        if status {
            guard let winScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: winScene)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            let navController = UINavigationController(rootViewController: initialViewController)
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

