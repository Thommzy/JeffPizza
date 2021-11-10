//
//  CartPizzaList+CoreDataProperties.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 09/11/2021.
//
//

import Foundation
import CoreData


extension CartPizzaList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartPizzaList> {
        return NSFetchRequest<CartPizzaList>(entityName: "CartPizzaList")
    }

    @NSManaged public var cartName: String?
    @NSManaged public var cartImage: String?
    @NSManaged public var cartItemTotal: Int64
    @NSManaged public var cartpizzaquantitylist: NSSet?

}

// MARK: Generated accessors for cartpizzaquantitylist
extension CartPizzaList {

    @objc(addCartpizzaquantitylistObject:)
    @NSManaged public func addToCartpizzaquantitylist(_ value: CartPizzaQuantityList)

    @objc(removeCartpizzaquantitylistObject:)
    @NSManaged public func removeFromCartpizzaquantitylist(_ value: CartPizzaQuantityList)

    @objc(addCartpizzaquantitylist:)
    @NSManaged public func addToCartpizzaquantitylist(_ values: NSSet)

    @objc(removeCartpizzaquantitylist:)
    @NSManaged public func removeFromCartpizzaquantitylist(_ values: NSSet)

}

extension CartPizzaList : Identifiable {

}
