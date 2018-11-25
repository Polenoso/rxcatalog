//
//  Date+Utils.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

class DateUtils {
    
    enum DateDisplay: String {
        case displayed = "dd/MM/YYYY"
    }
    
    static func stringDate(from: Int, with:DateDisplay) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(from))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = with.rawValue
        return dateFormatter.string(from: date)
    }
}
