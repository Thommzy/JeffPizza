//
//  OnBoardingViewController+Extension.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 29/10/2021.
//

import UIKit


extension OnBoardingViewController {
    func setupPresentMainTabBarController(userStatus: Bool, logInStatus: Bool) {
        UserDefaults.standard.set(userStatus, forKey: Constants.isMarried)
        UserDefaults.standard.set(logInStatus, forKey: Constants.isLoggedIn)
        let storyboard = UIStoryboard(name: Constants.main, bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.mainTabBarController)
        mainTabBarController.modalPresentationStyle = .overFullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
    }
}
