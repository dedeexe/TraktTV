//
//  TMDBEntity.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation
import ObjectMapper

public struct TMDBEntity : Mappable {
    
    public var id               : Int?
    public var poster_path      : String?
    
    public init() {}
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        id              <- map["id"]
        poster_path     <- map["poster_path"]
    }
    
}
