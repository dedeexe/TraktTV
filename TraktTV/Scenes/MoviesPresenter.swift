//
//  MoviesPresenter
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public class MoviesPresenter {
    
    fileprivate weak var view   : MoviesView?
    fileprivate var interactor  : MoviesInput?
    fileprivate var router      : MoviesWireframe?
    
    fileprivate var page        : Int = 0
    fileprivate var pageCount   : Int = 1
    fileprivate let quantity    : Int = 40
    
    fileprivate var movies      : [Movie] = []
    
    public init() {}
    
    public func inject(view: MoviesView?, interactor:MoviesInput?, router:MoviesWireframe?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    fileprivate func assertDependencies() {
        assert(view != nil, "No view defined in presenter")
        assert(interactor != nil, "No interactor defined in presenter")
        assert(router != nil, "No router defined in presenter")
    }
    
}

// MARK: - Presenter Delegates
extension MoviesPresenter : MoviesModule {
    public func getMovies() {
        
        interactor?.getMovies(at: page, groupedBy: quantity)
    }
}

// MARK: - Output Interactor Delegate
extension MoviesPresenter : MoviesOutput {
    public func fetch(movies: [Movie]) {
        self.movies.append(contentsOf: movies)
    }
    
    public func error(code: Int, description: String) {
        self.view?.showAlert(message: "Falha ao recuperar filmes.", titled: nil)
    }
}
