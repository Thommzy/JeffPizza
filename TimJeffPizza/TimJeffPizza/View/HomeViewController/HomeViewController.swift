//
//  HomeViewController.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 28/10/2021.
//

import UIKit

class HomeViewController: UIViewController {
    let appViewModel = AppViewModel(dataService: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appViewModel.delegate = self
        appViewModel.getPizzaList()
    }
}

extension HomeViewController: GetListOfPizzaProtocol {
    func listPizza(pizza: [JeffPizzaListResponseModel]?) {
        if let pizza = pizza {
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
