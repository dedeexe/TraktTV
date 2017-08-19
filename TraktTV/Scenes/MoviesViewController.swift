//
//  MoviesViewController.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    fileprivate var presenter : MoviesPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        presenter?.getMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    public func inject(presenter:MoviesPresenter?) {
        self.presenter = presenter
    }
    
    fileprivate func assertDependencies() {
        assert(presenter != nil, "Did not set Presenter to the view")
    }
}

//MARK: - View Delegate
extension MoviesViewController : MoviesView {
    func show(movies: [Movie]) {
        
    }
}
