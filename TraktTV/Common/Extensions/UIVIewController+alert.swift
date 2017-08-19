//
//  UIVIew+alert.swift
//  Dede.exe
//
//  Created by Dede on 02/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import UIKit

extension UIViewController : Alertable {}

extension UIViewController {
    
    func alertMessage(title:String?, message:String, buttonTitle:String = "Ok", completion:(() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            completion?()
        }))
        
        DispatchQueue.main.async { 
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
}
