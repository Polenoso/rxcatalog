//
//  String+Utils.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

extension String {
    func toInt() -> Int {
        return Int(self) ?? 0
    }
}
