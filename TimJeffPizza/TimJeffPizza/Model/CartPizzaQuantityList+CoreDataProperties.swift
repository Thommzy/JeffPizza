//
//  CartPizzaQuantityList+CoreDataProperties.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 09/11/2021.
//
//

import Foundation
import CoreData


extension CartPizzaQuantityList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartPizzaQuantityList> {
        return NSFetchRequest<CartPizzaQuantityList>(entityName: "CartPizzaQuantityList")
    }

    @NSManaged public var pizzaQuantity: Int64
    @NSManaged public var pizzaSize: String?
    @NSManaged public var cartpizzalist: CartPizzaList?

}

extension CartPizzaQuantityList : Identifiable {

}
