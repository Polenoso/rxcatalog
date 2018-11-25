//
//  CatalogSectionHeaderCollectionReusableView.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class CatalogSectionHeaderCollectionReusableView: UICollectionReusableView {
    
    static let ReusableIdentifier = "CatalogSectionHeaderCollectionReusableView"
    
    @IBOutlet var titleSectionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(title: String?) {
        titleSectionLabel.text = title
    }
    
    static func sizeForHeader(with title: String?, in frame: CGRect) -> CGSize {
        return CGSize(width: frame.width, height: 64)
    }
    
}
