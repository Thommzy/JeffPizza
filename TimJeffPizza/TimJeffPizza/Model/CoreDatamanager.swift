//
//  CoreDatamanager.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 09/11/2021.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager(modelName: "CartList")
    
    var persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError("An error occured while saving \(error.localizedDescription)")
            }
        }
    }
}


extension CoreDataManager {

    func createPizzaQuantityList(quantity: Int64, size: String) -> CartPizzaQuantityList {
        let cartQuantityList = CartPizzaQuantityList(context: viewContext)
        cartQuantityList.pizzaQuantity = quantity
        cartQuantityList.pizzaSize = size
        save()
        return cartQuantityList
    }
    
    func fetchData() -> [CartPizzaList] {
        let request: NSFetchRequest<CartPizzaList> = CartPizzaList.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("An error occured while saving \(error.localizedDescription)")
        }
    }
    
    func deleteData(_ data: CartPizzaList) {
        viewContext.delete(data)
        save()
    }
}
