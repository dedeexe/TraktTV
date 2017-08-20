//
//  MoviesConfigurator.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

public class MoviesConfigurator {
    
    public init() {}
    
    func create() throws -> MoviesViewController {
        
        guard let viewController = StoryboardIdentifier.movies.storyboard?.instantiateViewController(withIdentifier: "MoviesViewController") as? MoviesViewController else {
            throw ConfiguratorError.viewControllerNotFound
        }
        
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
        let interactor = MoviesInputInteractor()
        
        presenter.inject(view: viewController, interactor: interactor, router: router)
        interactor.inject(output: presenter)
        viewController.inject(presenter: presenter)
        viewController.inject(tableHandler: presenter)
        router.inject(viewController: viewController)
        
        return viewController
    }
    
}
