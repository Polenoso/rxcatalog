//
//  ViewModelType.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation


protocol ViewModelKind: class {
    associatedtype Output
    associatedtype Input
    
    var dataSource: Input { get }
    var output: Output { get set }
}
