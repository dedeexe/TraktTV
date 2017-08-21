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
    @IBOutlet weak var closeButton          : UIButton!

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
        setBlackStatusBar()
        setupCloseButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    func setupCloseButton() {
        closeButton.setTitle(UnicodeSymbols.close.rawValue, for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        closeButton.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        closeButton.layer.cornerRadius = closeButton.bounds.height / 2
        closeButton.layer.masksToBounds = true
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


// MARK: - Actions
extension MovieDetailViewController  {
    func closeAction(sender:UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
