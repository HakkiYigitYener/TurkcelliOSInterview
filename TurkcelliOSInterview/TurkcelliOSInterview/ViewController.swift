//
//  ViewController.swift
//  TurkcelliOSInterview
//
//  Created by Hakkı Yiğit Yener on 7.04.2018.
//  Copyright © 2018 Hakkı Yiğit Yener. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = ProductDataSource()
    
    lazy var viewModel : ProductViewModel = {
        let viewModel = ProductViewModel(dataSource: dataSource)
        return viewModel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCell")
        
        collectionView.delegate = self.dataSource
        
        
        self.collectionView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.collectionView.reloadData()
        }
        
        self.viewModel.fetchProducts(completionHandler: { (products:ProductListResponse) in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

