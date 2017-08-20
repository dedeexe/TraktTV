//
//  AppConfig.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public final class AppConfig {
    
    init() {}
    
    public let baseURL          = "https://api.trakt.tv"
    public let clientId         = "cf19f8544fd122d272b78df2e0ef0c651438f847d19f845b6406398c12fb4785"
    public let secretId         = "7086c33bfa6ba882c86f026c58553ca800943e7350a6f091c2dda675908fbbfb"
    public let apiVersion       = 2
    
    public let tmdbBaseURL      = "https://api.themoviedb.org/3"
    public let tmdbApiKey           = "e6ccbdc37943289e20ec01f6c8ffda28"
    
    public let tmdbMovieImageBaseURL     = "https://api.themoviedb.org/3/movie/137113?api_key=e6ccbdc37943289e20ec01f6c8ffda28"
}
