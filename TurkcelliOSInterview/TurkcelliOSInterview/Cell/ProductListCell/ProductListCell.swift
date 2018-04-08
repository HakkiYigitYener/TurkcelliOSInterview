//
//  ProductListCell.swift
//  TurkcelliOSInterview
//
//  Created by Hakkı Yiğit Yener on 7.04.2018.
//  Copyright © 2018 Hakkı Yiğit Yener. All rights reserved.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var product : Product? {
        didSet {
            guard let product = product else {
                return
            }
            
            titleLabel.text = product.name
            priceLabel.text = "\(product.price ?? 0) TL"
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
