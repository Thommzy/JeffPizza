//
//  CartListViewController.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 09/11/2021.
//

import UIKit

class CartListViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var payBtnParentView: UIView!
    @IBOutlet weak var tableViewHeightConst: NSLayoutConstraint!
    @IBOutlet weak var noItemLbl: UILabel!
    
    var cartArray: [CartPizzaList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleNavbar()
        fetchDataFromStorage()
        setupCartTableView()
        setupPayBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTableviewOberver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTableviewObserver()
    }
    
    func setupTitleNavbar() {
        navigationItem.title = "Cart"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: "Helvetica-Bold", size: 25) ?? UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.label]
    }
    
    func setupCartTableView() {
        cartTableView.register(UINib(nibName: PizzaCartTableViewCell.identifer, bundle: nil), forCellReuseIdentifier: PizzaCartTableViewCell.identifer)
    }
    
    func setupPayBtn() {
        payBtn.setupViewBorder(cornerRadius: 15, borderWidth: nil, masksToBound: true)
    }
    
    private func fetchDataFromStorage() {
        cartArray = CoreDataManager.shared.fetchData()
        
        if cartArray.count < 1 {
            payBtnParentView.isHidden = true
            noItemLbl.isHidden = false
        } else {
            payBtnParentView.isHidden = false
            noItemLbl.isHidden = true
        }
        totalAmountLabel.text = "$\(cartArray.map{$0.cartItemTotal}.reduce(0, +))"
    }
    
    @IBAction func payBtnAction(_ sender: UIButton) {
        let popupVc = PopupViewController(nibName: "PopupViewController", bundle: nil)
        popupVc.totalPrice = totalAmountLabel.text
        let userType = UserDefaults.standard.bool(forKey: "isMarried")
        switch userType {
        case true:
            popupVc.isMarried = true
        case false:
            popupVc.isMarried = false
        }
        let navigationCtrl = UINavigationController(rootViewController: popupVc)
        navigationCtrl.modalPresentationStyle = .overFullScreen
        self.present(navigationCtrl, animated: true, completion: nil)
    }
}

extension CartListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: PizzaCartTableViewCell?  = tableView.dequeueReusableCell(withIdentifier: PizzaCartTableViewCell.identifer, for: indexPath) as? PizzaCartTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(PizzaCartTableViewCell.identifer, owner: self, options: nil)?.first as? PizzaCartTableViewCell
        }
        cell?.setup(pizza: cartArray[indexPath.row])
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            CoreDataManager.shared.deleteData(cartArray[indexPath.row])
            cartArray.remove(at: indexPath.row)
            if cartArray.count < 1 {
                payBtnParentView.isHidden = true
                noItemLbl.isHidden = false
            }
            cartTableView.deleteRows(at: [indexPath], with: .right)
            totalAmountLabel.text = "$\(cartArray.map{$0.cartItemTotal}.reduce(0, +))"
        }
    }}

//MARK: - Tableview Observer
extension CartListViewController {
    
    private func addTableviewOberver() {
        self.cartTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    private func removeTableviewObserver() {
        if self.cartTableView.observationInfo != nil {
            self.cartTableView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UITableView {
            if obj == self.cartTableView && keyPath == "contentSize" {
                self.tableViewHeightConst.constant = self.cartTableView.contentSize.height
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
        }
    }
}
