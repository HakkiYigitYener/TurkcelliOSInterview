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
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(ProductListResponse.self, from: data!)
            DispatchQueue.main.async {
                completion(responseModel!)
            }
        }
        task.resume()
    }

}
