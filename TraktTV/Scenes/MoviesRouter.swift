//
//  MoviesRouter.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

public class MoviesRouter {
    
    fileprivate weak var viewController : UIViewController?
    
    public init() {}
    
    public func inject(viewController:UIViewController?) {
        self.viewController = viewController
    }
    
    fileprivate func assertDependencies() {
        assert(viewController != nil, "ViewController was not set to the Router")
    }
    
    public func gotoInsideApplication() {
        assertDependencies()
    }
    
}

//MARK: - Wireframe Delegate
extension MoviesRouter : MoviesWireframe {
    public func gotoSomeplace() {

    }
}
