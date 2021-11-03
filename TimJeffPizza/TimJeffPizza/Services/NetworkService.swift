//
//  NetworkService.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 29/10/2021.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    func parse(completion: @escaping ([JeffPizzaListResponseModel]?, Error?) -> ()) {
        let api = URL(string: "\(Constants.baseURL)/c9c124b0899ae9adc254146783c0b764/raw")
        
        URLSession.shared.dataTask(with: api!) {
            data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? String())
            }
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([JeffPizzaListResponseModel].self, from: data)
                    completion(result, nil)
                    return
                    
                }
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
}
