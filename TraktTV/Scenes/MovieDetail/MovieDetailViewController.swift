//
//  MovieDetailViewController.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView            : UITableView!

    fileprivate var presenter               : MovieDetailModule?
    fileprivate var tableHandler            : MovieDetailTableHandler?
    fileprivate var tableHandlerDelegate    : MovieDetailTableHandlerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        setup()
        presenter?.getMovie()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func inject(presenter:MovieDetailPresenter?) {
        self.presenter = presenter
    }
    
    public func inject(tableHandler:MovieDetailTableHandlerDelegate?) {
        self.tableHandlerDelegate = tableHandler
    }
    
    fileprivate func assertDependencies() {
        assert(presenter != nil, "Did not set Presenter to the view")
    }
    
    func setup() {
        setupTableView()
    }
}

// MARK: - Congigurations
extension MovieDetailViewController {
    func setupTableView() {
        tableHandler = MovieDetailTableHandler(with: presenter?.imageLoader)
        tableHandler?.handlerDelegate = tableHandlerDelegate
        tableView.delegate = tableHandler
        tableView.dataSource = tableHandler
    }
}

// MARK: - View Delegate
extension MovieDetailViewController : MovieDetailView {
    func reload() {
        DispatchQueue.main.async {[unowned self] in
            self.tableView.reloadData()
        }
    }
}
