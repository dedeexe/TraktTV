//
//  MoviesInteractor.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public protocol MoviesInput : class {
    func getMovies(at page:Int, groupedBy quantity:Int)
}

public protocol MoviesOutput : class {
    func fetch(movies:[Movie])
    func error(code:Int, description:String)
}
