//
//  NetworkManager.swift
//  TurkcelliOSInterview
//
//  Created by Hakkı Yiğit Yener on 7.04.2018.
//  Copyright © 2018 Hakkı Yiğit Yener. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {
    }
    
    func saveProducts(products: [Product]) {
        clearProducts()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let productEntity = NSEntityDescription.entity(forEntityName: "ProductDM", in: managedContext)!
        
        for product in products {
            let productObject = NSManagedObject(entity: productEntity, insertInto: managedContext)
            productObject.setValue(product.productId, forKeyPath: "productId")
            productObject.setValue(product.name, forKey: "name")
            productObject.setValue(product.image, forKey: "image")
            productObject.setValue(product.price, forKey: "price")
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func clearProducts() {
        // create the delete request for the specified entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductDM")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // get reference to the persistent container
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // perform the delete
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func getProducts() -> [Product] {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return [Product]()
            
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let productFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductDM")
        
        if let productDMs = try? managedContext.fetch(productFetch) {
            var products = [Product]()
            for productDM in productDMs {
                if let object = productDM as? ProductDM {
                    products.append(Product(from: object))
                }
            }
        }
        
        return [Product]()
    }

}
