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
    @IBOutlet weak var continueBtn: UIButton!
    
    var totalAmount: String?
    var pizzaName: String?
    var totalPrice: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("summary", comment: "This is summary Text.")
        setupDatas()
        setupContinueBtn()
    }
    
    
    func setupDatas() {
        let userType = UserDefaults.standard.bool(forKey: NSLocalizedString("isMarried", comment: "isMarried"))
        switch userType {
        case true:
            statusLabel.text = NSLocalizedString("married", comment: "married")
        case false:
            statusLabel.text = NSLocalizedString("single", comment: "single")
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
        let alert = UIAlertController(title: NSLocalizedString("appContinue", comment: "appContinue"), message: NSLocalizedString("continueMessage", comment: "appContinue"), preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("appContinue", comment: "appContinue"), style: UIAlertAction.Style.destructive, handler: { [weak self] action in
            self?.setupMoveToMainScreen()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("appCancel", comment: "appCancel"), style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupMoveToMainScreen() {
        let storyboard = UIStoryboard(name: NSLocalizedString("main", comment: "main"), bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: NSLocalizedString("mainTabBarController", comment: "mainTabBarController"))
        mainTabBarController.modalPresentationStyle = .overFullScreen
        let data = CoreDataManager.shared.fetchData()
        _ = data.map{CoreDataManager.shared.deleteData($0)}
        self.present(mainTabBarController, animated: true, completion: nil)
    }
}
