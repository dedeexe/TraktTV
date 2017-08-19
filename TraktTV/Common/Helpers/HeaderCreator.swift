//
//  HeaderCreator.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public struct HeaderCreator {
    
    public init() {}
    
    public var standard : [String:String] {
        
        let header : [String:String] = [
            "trakt-api-key"     : AppConfig().clientId,
            "trakt-api-version" : AppConfig().apiVersion
        ]
        
        return header
        
    }
    
}
