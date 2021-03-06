//
//  OnBoardingViewController.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 28/10/2021.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    @IBOutlet weak var singleParentView: UIView!
    @IBOutlet weak var marriedParentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSingleParentView()
        setupMarriedParentView()
    }
    
    func setupMarriedParentView() {
        marriedParentView.setupViewBorder(cornerRadius: 10, borderWidth: 5, masksToBound: nil)
    }
    
    func setupSingleParentView() {
        singleParentView.setupViewBorder(cornerRadius: 10, borderWidth: 5, masksToBound: nil)
    }
    
    @IBAction func marriedBtnAction(_ sender: UIButton) {
        setupPresentMainTabBarController(userStatus: true, logInStatus: true)
    }
    
    @IBAction func singleBtnAction(_ sender: UIButton) {
        setupPresentMainTabBarController(userStatus: false, logInStatus: true)
    }
}
