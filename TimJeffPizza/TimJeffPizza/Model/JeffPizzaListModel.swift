//
//  JeffPizzaListModel.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 29/10/2021.
//

import Foundation

// MARK: - JeffPizzaListResponseModel
struct JeffPizzaListResponseModel: Codable {
    let id: Int
    let name, content: String
    let imageURL: String
    let prices: [Price]

    enum CodingKeys: String, CodingKey {
        case id, name, content
        case imageURL = "imageUrl"
        case prices
    }
}

