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
    public var release_date     : String?
    public var runtime          : Int?
    public var tagline          : String?
    public var overview         : String?
    public var vote_average     : Float?
    public var genres           : [Genre]?

    public init() {}
    public init?(map: Map) {}
    
    public mutating func mapping(map: Map) {
        id              <- map["id"]
        poster_path     <- map["poster_path"]
        release_date    <- map["release_date"]
        runtime         <- map["runtime"]
        tagline         <- map["tagline"]
        overview        <- map["overview"]
        vote_average    <- map["vote_average"]
        genres          <- map["genres"]
    }
    
}

//Movie’s name, release date, runtime, tagline, overview and rating, genres and a image gallery
