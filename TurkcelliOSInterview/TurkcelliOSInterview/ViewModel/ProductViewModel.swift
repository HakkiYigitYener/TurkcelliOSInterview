//
//  CurrencyViewModel.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct ProductViewModel {
    
    weak var dataSource : GenericDataSource<Product>?
    
    init(dataSource : GenericDataSource<Product>?) {
        self.dataSource = dataSource
    }
    
    func fetchProducts(completionHandler: @escaping (ProductListResponse) -> Void){
        
        NetworkManager.shared.getProductList { (response:ProductListResponse) in
            if let products = response.products {
                self.dataSource?.data.value = products
            }
            
            completionHandler(response)
        }
    }
    

}
