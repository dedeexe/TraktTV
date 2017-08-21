//
//  MovieDetailConfigurator.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

public class MovieDetailConfigurator {
    
    public init() {}
    
    func create(using movie:Movie) throws -> MovieDetailViewController {
        
        guard let viewController = StoryboardIdentifier.movies.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            throw ConfiguratorError.viewControllerNotFound
        }
        
        let presenter = MovieDetailPresenter(movie: movie)
        let router = MovieDetailRouter()
        let interactor = MovieDetailInputInteractor()
        
        presenter.inject(view: viewController, interactor: interactor, router: router)
        interactor.inject(output: presenter)
        viewController.inject(presenter: presenter)
        router.inject(viewController: viewController)
        
        return viewController
    }
    
}

