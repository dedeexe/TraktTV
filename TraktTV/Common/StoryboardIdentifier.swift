//
//  StoryboardIdentifier.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

public enum StoryboardIdentifier : String {
    
    case movies            = "Movies"
    
    public var storyboard : UIStoryboard? {
        let sb = UIStoryboard(name: self.rawValue, bundle: nil)
        return sb
    }
    
}
