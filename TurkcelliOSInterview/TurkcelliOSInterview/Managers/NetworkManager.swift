//
//  NetworkManager.swift
//  TurkcelliOSInterview
//
//  Created by Hakkı Yiğit Yener on 7.04.2018.
//  Copyright © 2018 Hakkı Yiğit Yener. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
    }
    
    func getProductList(completion: @escaping (ProductListResponse) -> Void){
        let url = URL(string: "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard error == nil else {
                print("Error: calling GET on /cart/list")
                print(error!)
                return
            }
            guard data != nil else {
                print("Error: did not receive data")
                return
            }
            guard let responseModel = try? JSONDecoder().decode(ProductListResponse.self, from: data!)
                else {
                    print("error trying to convert data to object")
                    return
            }
            
            DispatchQueue.main.async {
                completion(responseModel)
            }
            
        }
        task.resume()
    }
    
    func getProductDetail(productId: String, completion: @escaping (Product) -> Void){
        let url = URL(string: "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/\(productId)/detail")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard error == nil else {
                print("Error: calling GET on /cart/\(productId)/detail")
                print(error!)
                return
            }
            guard data != nil else {
                print("Error: did not receive data")
                return
            }
            guard let responseModel = try? JSONDecoder().decode(Product.self, from: data!)
                else {
                    print("error trying to convert data to object")
                    return
            }
            
            DispatchQueue.main.async {
                completion(responseModel)
            }
            
        }
        task.resume()
    }

}
