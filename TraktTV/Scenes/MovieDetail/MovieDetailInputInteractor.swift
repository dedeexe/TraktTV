//
//  MovieDetailInputInteractor.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public class MovieDetailInputInteractor : MovieDetailInput {
    
    fileprivate weak var output : MovieDetailOutput?
    fileprivate var movieInteractor : MoviesInputInteractor?
    
    public init() {
        movieInteractor = MoviesInputInteractor()
        movieInteractor?.inject(output: self)
    }
    
    public func inject(output:MovieDetailOutput?) {
        self.output = output
    }

    private func assertDependencies() {
   		assert(output != nil, "Did not set output to the input interactor")
    }
    
    public func get(something:String) {
        assertDependencies()
        //Implement how to get data here
    }
    
    public func getMovieBy(tmdb id: Int) {
        movieInteractor?.getMovieBy(tmdb: id)
    }
}

extension MovieDetailInputInteractor : MoviesOutput {
    public func fetch(currentPage: Int, pagesCount: Int) {}
    public func fetch(movies: [Movie]) {}
    
    public func fetch(movie: TMDBEntity) {
        self.output?.fetch(movie: movie)
    }
    
    public func error(code: Int, description: String) {}
}
