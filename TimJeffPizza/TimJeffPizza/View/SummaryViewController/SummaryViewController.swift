//
//  SummaryViewController.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 03/11/2021.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var totalaAmountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var pizzaNameLabel: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    
    var totalAmount: String?
    var pizzaName: String?
    var totalPrice: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Constants.summary
        setupDatas()
        setupContinueBtn()
    }
    
    
    func setupDatas() {
        pizzaNameLabel.text = pizzaName
        let userType = UserDefaults.standard.bool(forKey: Constants.isMarried)
        switch userType {
        case true:
            statusLabel.text = Constants.married
        case false:
            statusLabel.text = Constants.single
        }
        totalaAmountLabel.text = totalPrice
    }
    
    func setupContinueBtn() {
        continueBtn.setupViewBorder(cornerRadius: 15, borderWidth: nil, masksToBound: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func continueBtnAction(_ sender: UIButton) {
        let alert = UIAlertController(title: Constants.appContinue, message: Constants.continueMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.appContinue, style: UIAlertAction.Style.destructive, handler: { [weak self] action in
            self?.setupMoveToMainScreen()
        }))
        alert.addAction(UIAlertAction(title: Constants.appCancel, style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupMoveToMainScreen() {
        let storyboard = UIStoryboard(name: Constants.main, bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: Constants.mainTabBarController)
        mainTabBarController.modalPresentationStyle = .overFullScreen
        self.present(mainTabBarController, animated: true, completion: nil)
    }
}
