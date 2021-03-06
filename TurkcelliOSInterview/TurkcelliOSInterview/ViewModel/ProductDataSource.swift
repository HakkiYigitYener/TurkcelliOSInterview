//
//  CurrencyDataSource.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 24/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([]) 
    var filteredData: DynamicValue<[T]> = DynamicValue([])
}

class ProductDataSource : GenericDataSource<Product>, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cache:NSCache<AnyObject, AnyObject> = NSCache()
    
    var searchText: String = "" {
        didSet{
            if searchText == "" {
                filteredData.value = data.value
            }
            else {
                filteredData.value = data.value.filter {
                    $0.name?.range(of: searchText, options: .caseInsensitive) != nil}
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        
        cell.product = filteredData.value[indexPath.row]
        
        
        cell.imageView.image = nil
        
        if let imageURL = cell.product?.image {
            if (self.cache.object(forKey: imageURL as AnyObject) != nil){
                cell.imageView?.image = self.cache.object(forKey: imageURL as AnyObject) as? UIImage
            }else{
                let url:URL! = URL(string: imageURL)
                let task = URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                    if let data = try? Data(contentsOf: url){
                        DispatchQueue.main.async(execute: { () -> Void in
                            if let updateCell = collectionView.cellForItem(at: indexPath) as? ProductListCell{
                                let img:UIImage! = UIImage(data: data)
                                updateCell.imageView.image = img
                                self.cache.setObject(img, forKey: imageURL as AnyObject)
                            }
                        })
                    }
                })
                task.resume()
            }
        }
        return cell
    }
        
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = UIScreen.main.bounds.size.width
        let itemWidth = (screenWidth - (8.0 + 8.0 + 8.0)) / 2.0
        let itemHeight = ((itemWidth * 9.0) / 16.0) + 66
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
