//
//  MovieDetailInteractor.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public protocol MovieDetailInput : class {
    func getMovieBy(tmdb id:Int)
}

public protocol MovieDetailOutput : class {
    func fetch(movie:TMDBEntity)
}
