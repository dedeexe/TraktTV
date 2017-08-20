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
    fileprivate var tableHandler : MoviesTableHandler?
    fileprivate var tableHandlerDelegate : MoviesTableHandlerDelegate?
    
    fileprivate var presenter : MoviesModule?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        setup()
        presenter?.getMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func inject(presenter:MoviesPresenter?) {
        self.presenter = presenter
    }
    
    public func inject(tableHandler: MoviesTableHandlerDelegate) {
        self.tableHandlerDelegate = tableHandler
    }
    
    fileprivate func assertDependencies() {
        assert(presenter != nil, "Did not set Presenter to the view")
    }
    
    fileprivate func setup() {
        setupTableHandler()
    }
}

// MARK: - Configurations
extension MoviesViewController {
    func setupTableHandler() {
        tableHandler = MoviesTableHandler(with: presenter?.imageLoader)
        tableHandler?.handlerDelegate = tableHandlerDelegate
        tableView.delegate = tableHandler
        tableView.dataSource = tableHandler
    }
}

// MARK: - View Delegate
extension MoviesViewController : MoviesView {
    func reload() {
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func reloadCellAtIndex(index: Int) {
        tableHandler?.reloadCellAtIndex(index)
    }
}
