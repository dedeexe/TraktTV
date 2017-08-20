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
        self.log(level: .verbose, "New Messages requested")
        interactor?.getMovies(at: page, groupedBy: quantity)
    }
}

// MARK: - Output Interactor Delegate
extension MoviesPresenter : MoviesOutput {
    public func fetch(movies: [Movie]) {
        self.movies.append(contentsOf: movies)
        view?.reload()
    }
    
    public func error(code: Int, description: String) {
        self.view?.showAlert(message: "Falha ao recuperar filmes.", titled: nil)
    }
}

// MARK: - Output Interactor Delegate
extension MoviesPresenter : MoviesTableHandlerDelegate {
    public func moviesTableHandlerDidRequestNewItems(handler: MoviesTableHandler) {
        
    }
    
    public func moviesTableHandler(handler: MoviesTableHandler, didSelectItemAt indexPath: IndexPath) {
        
    }
}