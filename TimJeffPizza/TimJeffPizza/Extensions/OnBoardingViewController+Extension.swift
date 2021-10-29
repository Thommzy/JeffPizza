//
//  OnBoardingViewController+Extension.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 29/10/2021.
//

import UIKit


extension OnBoardingViewController {
    func setupPresentMainTabBarController(userStatus: Bool, logInStatus: Bool) {
        UserDefaults.standard.set(userStatus, forKey: "isMarried")
        UserDefaults.standard.set(logInStatus, forKey: "isLoggedIn")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        mainTabBarController.modalPresentationStyle = .overFullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
    }
}