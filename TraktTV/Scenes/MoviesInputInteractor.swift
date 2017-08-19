//
//  MoviesInputInteractor.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public class MoviesInputInteractor : MoviesInput, Loggable {
    
    public var defaultLoggingTag: LogTag = .interactor
    
    fileprivate weak var output : MoviesOutput?
    
    public func inject(output:MoviesOutput?) {
        self.output = output
    }

    private func assertDependencies() {
   		assert(output != nil, "Did not set output to the input interactor")
    }
    
    public func getMovies(at page: Int, groupedBy quantity: Int) {
        self.log(level: .verbose, "Trying to get more \(quantity) item at page \(page)")
        
        let service = MovieListService(page: page, pageSize: quantity)
        
        service.get { [unowned self] (result, headers) in
            switch result {
                case .success(_, let movies):
                    self.output?.fetch(movies: movies)
                case .fail(let code, let error):
                    self.output?.error(code: code, description: error.localizedDescription)
            }
        }
    }

}
