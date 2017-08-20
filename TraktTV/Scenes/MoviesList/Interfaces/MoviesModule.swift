//
//  MoviesModule
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public protocol MoviesModule {
    var imageLoader : ImageLoader? { get }
    
    func getMovies()
}
