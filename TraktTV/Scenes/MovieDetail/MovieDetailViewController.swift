//
//  MovieDetailViewController.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    fileprivate var presenter : MovieDetailModule?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assertDependencies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func inject(presenter:MovieDetailPresenter?) {
        self.presenter = presenter
    }
    
    fileprivate func assertDependencies() {
        assert(presenter != nil, "Did not set Presenter to the view")
    }
}

//MARK: - View Delegate
extension MovieDetailViewController : MovieDetailView {
    func show(movie: Movie?) {
        
    }
}
