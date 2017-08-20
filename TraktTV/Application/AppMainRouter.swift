//
//  AppMainRouter.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

public class AppMainRouter {
    public init() {}
    
    func gotoMainScreen(using window:UIWindow) {
        DispatchQueue.main.async {
            guard let viewController = try? MoviesConfigurator().create() else { return }
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
    }
    
}
