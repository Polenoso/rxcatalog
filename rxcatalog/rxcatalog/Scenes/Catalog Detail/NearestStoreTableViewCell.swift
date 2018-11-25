//
//  NearestStoreTableViewCell.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import UIKit

class NearestStoreTableViewCell: UITableViewCell {
    
    static let ReuseIdentifer = "NearestStoreTableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(data:(title: String?, description:String?)) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }

}
