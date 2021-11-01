//
//  AppViewModel.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 29/10/2021.
//

import Foundation

class AppViewModel {

    private var dataService: NetworkServiceProtocol?
    var delegate: GetListOfPizzaProtocol?
    
    // MARK: - Constructor
    init(dataService: NetworkServiceProtocol) {
        self.dataService = dataService
    }
    
    func getPizzaList() {
        self.dataService?.parse(completion: { result, error in
            if let error = error {
                self.delegate?.errorMessage(error: error)
            }
            self.delegate?.listPizza(pizza: result ?? [])
        })
    }
}
