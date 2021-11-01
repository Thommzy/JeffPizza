//
//  HomeViewController.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 28/10/2021.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var pizzaTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let appViewModel = AppViewModel(dataService: NetworkService())
    var pizzaArray: [JeffPizzaListResponseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appViewModel.delegate = self
        appViewModel.getPizzaList()
        setupPizzaTableView()
    }
    
    func setupPizzaTableView() {
        pizzaTableView.register(UINib(nibName: PizzaTableViewCell.identifer, bundle: nil), forCellReuseIdentifier: PizzaTableViewCell.identifer)
        pizzaTableView.isHidden = true
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        pizzaTableView.tableHeaderView = UIView(frame: frame)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: PizzaTableViewCell?  = tableView.dequeueReusableCell(withIdentifier: PizzaTableViewCell.identifer, for: indexPath) as? PizzaTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(PizzaTableViewCell.identifer, owner: self, options: nil)?.first as? PizzaTableViewCell
        }
        
        cell?.pizzaItem = pizzaArray[indexPath.row]
        cell?.selectionStyle = .none
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension HomeViewController: GetListOfPizzaProtocol {
    func listPizza(pizza: [JeffPizzaListResponseModel]?) {
        if let pizza = pizza {
            pizzaArray = pizza
            DispatchQueue.main.async {
                self.pizzaTableView.reloadData()
                self.pizzaTableView.isHidden = false
                self.spinner.stopAnimating()
            }
            print(pizza.count,"--->>>pizzaCount")
            print(pizza,"--->>>pizzaList")
        }
    }
    
    func errorMessage(error: Error?) {
        if let error = error {
            print("error--->>> \(error)")
        }
    }
}
