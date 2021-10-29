//
//  NetworkServiceProtocol.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 29/10/2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func parse(completion: @escaping ([JeffPizzaListResponseModel]?, Error?) -> ())
}
