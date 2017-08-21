//
//  MoviesPresenter
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public class MoviesPresenter : Loggable {
    
    public var defaultLoggingTag: LogTag = .presenter
    
    fileprivate weak var view               : MoviesView?
    fileprivate var interactor              : MoviesInput?
    fileprivate var router                  : MoviesWireframe?
    
    fileprivate var page                    : Int = 0
    fileprivate var pageCount               : Int = 1
    fileprivate let quantity                : Int = 40
    
    fileprivate(set) public var movies      : [Movie] = []
    
    fileprivate var pullRefreshed           : Bool = false
    
    public var imageLoader                  : ImageLoader? = TheImageDownloader.shared
    
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
        
        guard page < pageCount else { return }
        
        self.page += 1
        
        self.log(level: .verbose, "New Messages requested")
        interactor?.getMovies(at: page, groupedBy: quantity)
    }
}

// MARK: - Output Interactor Delegate
extension MoviesPresenter : MoviesOutput {
    public func fetch(movie: TMDBEntity) {
        if let index = mergeRightMovieWith(entity: movie) {
            view?.reloadCellAtIndex(index: index)
        }
    }

    public func fetch(movies: [Movie]) {
        if pullRefreshed {
            pullRefreshed = false
            self.movies.removeAll()
        }
        
        self.movies.append(contentsOf: movies)
        view?.stopPullRefresh()
        view?.reload()
        self.refreshTMDBEntities()
    }
    
    public func fetch(currentPage: Int, pagesCount: Int) {
        self.page = currentPage
        self.pageCount = pagesCount
    }
    
    public func error(code: Int, description: String) {
        self.view?.showAlert(message: "Falha ao recuperar filmes.", titled: nil)
    }
}


// MARK: - Helpers
extension MoviesPresenter {
    public func refreshTMDBEntities() {
        for movie in movies where movie.tmdbEntity == nil {
            guard let tmdbId = movie.ids?.tmdb else { continue }
            interactor?.getMovieBy(tmdb: tmdbId)
        }
    }
    
    public func mergeRightMovieWith(entity:TMDBEntity) -> Int?  {
        guard let id = entity.id else { return nil }
        guard let index = movies.index(where: { return $0.ids?.tmdb ?? -1 == id }) else { return nil }
        
        movies[index].tmdbEntity = entity
        return index
    }
}

// MARK: - Output Interactor Delegate
extension MoviesPresenter : MoviesTableHandlerDelegate {
    public func moviesTableHandlerDidRequestNewItems(handler: MoviesTableHandler) {
        getMovies()
    }
    
    public func moviesTableHandler(handler: MoviesTableHandler, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        router?.gotoDetails(of: movie)
    }
    
    public func moviesTableHandlerDidPullRefresh(handler: MoviesTableHandler) {
        page = 0
        pageCount = 1
        pullRefreshed = true
        getMovies()
    }
}
