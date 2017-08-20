//
//  UITableView+utils.swift
//  Dede.exe
//
//  Created by Dede on 21/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCell(named identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
}
