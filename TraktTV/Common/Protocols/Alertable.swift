//
//  Alertable.swift
//  Dede.exe
//
//  Created by Dede on 22/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import UIKit

public protocol Alertable {
    func showAlert(message:String, titled title:String?)
}

extension Alertable where Self : UIViewController {
    public func showAlert(message:String, titled title:String?) {
        self.alertMessage(title: title, message: message)
    }
}
