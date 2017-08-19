//
//  IDs.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation
import ObjectMapper

public struct IDs : Mappable {
    
    public var trakt    : Int?
    public var slug     : String?
    public var imdb     : String?
    public var tmdb     : Int?
    
    public init() {}
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        trakt   <- map["trakt"]
        slug    <- map["slug"]
        imdb    <- map["imdb"]
        tmdb    <- map["tmdb"]
    }
    
}
