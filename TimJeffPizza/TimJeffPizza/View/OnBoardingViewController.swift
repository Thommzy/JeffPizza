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
        marriedParentView.setupViewBorder(cornerRadius: 10, borderWidth: 5)
    }
    
    func setupSingleParentView() {
        singleParentView.setupViewBorder(cornerRadius: 10, borderWidth: 5)
    }
    
    @IBAction func marriedBtnAction(_ sender: UIButton) {
        
        print("Married")
    }
    
    @IBAction func singleBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        mainTabBarController.modalPresentationStyle = .overFullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
        print("Single")
    }
}
