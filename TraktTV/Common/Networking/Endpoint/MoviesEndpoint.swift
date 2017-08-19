//
//  MoviesEndpoint.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

enum MoviesEndpoint {
    case getMovie(id:Int)
    case getMovies(page:Int, size:Int)
}

extension MoviesEndpoint : Endpoint {
    
    var path: String {
        switch self {
            case .getMovie(let id):     return "movies/\(id)"
            case .getMovies:            return "/movies/popular"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var parameters: [String : Any] {
        switch self {
            case .getMovie:                         return [:]
            case .getMovies(let page, let size):    return ["page":page, "limit":size]
        }
    }
    
    var headers: [String : String] {
        return ["Content-Type":"application/json"]
    }
    
    var encoding: RequestEncoding {
        return url
    }
    
    var body: Data? {
        return nil
    }
    
}
