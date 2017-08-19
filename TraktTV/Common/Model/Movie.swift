//
//  Movie.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Movie : Mappable {
    
    public var title    : String?
    public var year     : Int?
    public var ids      : IDs?
    
    public init() {}
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        title   <- map["title"]
        year    <- map["year"]
        ids     <- map["ids"]
    }
    
}
