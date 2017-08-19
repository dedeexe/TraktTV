//
//  MoviesTableHandler.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

public protocol MoviesTableHandlerDelegate : class {
    var movies:[Movie] { get }
    func moviesTableHandler(handler:MoviesTableHandler, didSelectItemAt indexPath:IndexPath)
    func moviesTableHandlerDidRequestNewItems(handler:MoviesTableHandler)
}

public class MoviesTableHandler : NSObject {
    
    fileprivate(set) public var isShowLoading : Bool = false
    let offsetCell = 8
    
    weak var handlerDelegate : MoviesTableHandlerDelegate?
    weak var imageLoader : ImageLoader?
    weak var tableView : UITableView?
    
    public init(with imageLoader: ImageLoader?) {
        super.init()
        self.imageLoader = imageLoader
    }
    
    func setupTable(_ tableView:UITableView) {
        //tableView.backgroundColor = ColorPallete.tableView
        tableView.separatorStyle = .none
        
        tableView.registerCell(named: String(describing:LoadingCell.self))
        //tableView.registerCell(named: String(describing:MovieCell.self))
    }
    
    func showLoadingActivity() {
        isShowLoading = true
    }
    
    func hideLoadingActivity() {
        isShowLoading = false
    }
}

extension MoviesTableHandler : UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        self.tableView = tableView
        setupTable(tableView)
        return AppGenerics().justOne
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isShowLoading {
            return AppGenerics().justOne
        }
        
        return handlerDelegate?.movies.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isShowLoading {
            return createLoadingCell(in: tableView)
        }
        
        return createNotificationCell(in: tableView, at: indexPath)
    }
    
}

extension MoviesTableHandler : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let moviesCount = handlerDelegate?.movies.count ?? 0
        
        if indexPath.row == moviesCount - offsetCell {
            handlerDelegate?.moviesTableHandlerDidRequestNewItems(handler: self)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handlerDelegate?.moviesTableHandler(handler: self, didSelectItemAt: indexPath)
    }
}

// MARK: - Helpers
extension MoviesTableHandler {
    func createLoadingCell(in tableView:UITableView) -> UITableViewCell {
        let identifier = String(describing:LoadingCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LoadingCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell.selectionStyle = .none
        cell.startLoadingAnimation()
        return cell
    }
    
    func createNotificationCell(in tableView:UITableView, at indexPath:IndexPath) -> UITableViewCell {
        let identifier = String(describing:MovieCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        let notification = handlerDelegate?.movies[indexPath.row]
        cell.imageLoader = imageLoader
        cell.delegate = self
        cell.selectionStyle = .none
        cell.update(notification: notification, withIndex: indexPath)
        return cell
    }
    
    public func updateCell(at index:Int) {
        let indexPath = IndexPath(row: index, section: 0)
        
        tableView?.beginUpdates()
        tableView?.reloadRows(at: [indexPath], with: .fade)
        tableView?.endUpdates()
    }
}
