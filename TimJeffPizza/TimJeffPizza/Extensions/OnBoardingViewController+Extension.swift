//
//  OnBoardingViewController+Extension.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 29/10/2021.
//

import UIKit


extension OnBoardingViewController {
    func setupPresentMainTabBarController(userStatus: Bool, logInStatus: Bool) {
        UserDefaults.standard.set(userStatus, forKey: NSLocalizedString("isMarried", comment: "isMarried"))
        UserDefaults.standard.set(logInStatus, forKey: NSLocalizedString("isLoggedIn", comment: "isLoggedIn"))
        let storyboard = UIStoryboard(name: NSLocalizedString("main", comment: "main"), bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: NSLocalizedString("mainTabBarController", comment: "mainTabBarController"))
        mainTabBarController.modalPresentationStyle = .overFullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
    }
}
