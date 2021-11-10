//
//  SettingsViewController.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 03/11/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setuplogoutBtn()
    }
    
    func setuplogoutBtn() {
        logoutBtn.setupViewBorder(cornerRadius: 10, borderWidth: nil, masksToBound: true)
    }
    
    @IBAction func logoutBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(identifier: NSLocalizedString("onBoardingViewController", comment: "onBoardingViewController"))
        let navController = UINavigationController(rootViewController: initialViewController)
        UserDefaults.standard.set(false, forKey: NSLocalizedString("isLoggedIn", comment: "isLoggedIn"))
        navController.modalPresentationStyle = .overFullScreen
        self.present(navController, animated: true, completion: nil)
    }
}
