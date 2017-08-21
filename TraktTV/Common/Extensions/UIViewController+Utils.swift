//
//  UIViewController+Utils.swift
//  TraktTV
//
//  Created by dede.exe on 21/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

extension UIViewController {
    func setBlackStatusBar() {
        let rect = UIApplication.shared.statusBarFrame
        let statusBar = UIView(frame: rect)
        statusBar.backgroundColor = UIColor.black
        self.view.addSubview(statusBar)
    }
}
