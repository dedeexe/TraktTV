//
//  MovieDetailPresenter
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public class MovieDetailPresenter {
    
    fileprivate weak var view               : MovieDetailView?
    fileprivate var interactor              : MovieDetailInput?
    fileprivate var router                  : MovieDetailWireframe?
    fileprivate(set) public var imageLoader : ImageLoader? = TheImageDownloader.shared
    
    fileprivate(set) public var movie       : Movie?
    
    public init(movie:Movie?) {
        self.movie = movie
    }
    
    public func inject(view: MovieDetailView?, interactor:MovieDetailInput?, router:MovieDetailWireframe?) {
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
extension MovieDetailPresenter : MovieDetailModule {
    public func getMovie() {
        guard let _ = movie?.tmdbEntity else {
            let id = movie?.ids?.tmdb ?? 0
            interactor?.getMovieBy(tmdb: id)
            return
        }
        
        view?.reload()
    }
}

// MARK: - Output Interactor Delegate
extension MovieDetailPresenter : MovieDetailOutput {
    public func fetch(movie: TMDBEntity) {
        assertDependencies()
        self.movie?.tmdbEntity = movie
        self.view?.reload()
    }
}

// MARK: - Output Interactor Delegate
extension MovieDetailPresenter : MovieDetailTableHandlerDelegate {}
