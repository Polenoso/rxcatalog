//
//  CatalogsCollectionViewCell.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class CatalogsCollectionViewCell: UICollectionViewCell {

    static let ReuseIdentifier = "CatalogsCollectionViewCell"
    
    private static let maxSize: CGSize = CGSize(width: 175, height: 300)
    
    @IBOutlet var catalogImageView: UIImageView!
    @IBOutlet var catalogEndDate: UILabel!
    @IBOutlet var catalogRetailerName: UILabel!
    @IBOutlet var couponLabel: UILabel!
    
    func updateView(viewModel: CatalogsModels.Output.Catalog.Displayed) {
        //TODO: setup image
        let image = viewModel.type == .catalog ? UIImage(imageLiteralResourceName: "catalog") : UIImage(imageLiteralResourceName: "coupon")
        catalogImageView.image = image
        catalogEndDate.text = viewModel.date
        catalogRetailerName.text = viewModel.businessName
        couponLabel.isHidden = viewModel.type == .catalog
        isHidden = viewModel.type == .loading
    }

}
