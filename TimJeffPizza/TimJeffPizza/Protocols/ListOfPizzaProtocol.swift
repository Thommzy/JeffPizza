//
//  ListOfPizzaProtocol.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 29/10/2021.
//

import Foundation

protocol GetListOfPizzaProtocol {
    func listPizza(pizza: [JeffPizzaListResponseModel]?)
    func errorMessage(error: Error?)
}
