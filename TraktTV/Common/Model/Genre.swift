//
//  Genre.swift
//  TraktTV
//
//  Created by dede.exe on 21/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper

public struct Genre : Mappable {
    
    public var id       : Int?
    public var name     : String?
    
    public init() {}
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
    }
    
}
