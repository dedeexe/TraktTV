//
//  URLImage.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public class URLImage {
    public func tmdb(for movie:Movie?) -> String? {
        guard let posterPath = movie?.tmdbEntity?.poster_path else { return nil }
        let url = "https://image.tmdb.org/t/p/w500/\(posterPath)"
        return url
    }
}
