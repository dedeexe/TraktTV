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
    func moviesTableHandlerDidPullRefresh(handler:MoviesTableHandler)
}

public class MoviesTableHandler : NSObject {
    
    fileprivate(set) public var isShowLoading : Bool = false
    let offsetCell = 8
    
    weak var handlerDelegate : MoviesTableHandlerDelegate?
    weak var imageLoader : ImageLoader?
    weak var tableView : UITableView?
    
    var refreshControl : UIRefreshControl!
    
    public init(with imageLoader: ImageLoader?) {
        super.init()
        self.imageLoader = imageLoader
    }
    
    func setupTable(_ tableView:UITableView) {
        tableView.separatorStyle = .none
        
        tableView.registerCell(named: String(describing:LoadingCell.self))
        tableView.registerCell(named: String(describing:MovieCell.self))
        setupRefreshControl(tableView: tableView)
    }
    
    func setupRefreshControl(tableView:UITableView) {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    public func showLoadingActivity() {
        isShowLoading = true
    }
    
    public func hideLoadingActivity() {
        isShowLoading = false
    }
    
    public func endPullRefresh() {
        DispatchQueue.main.async { [unowned self] in
            self.refreshControl.endRefreshing()
        }
    }
    
    func reloadCellAtIndex(_ index:Int) {
        let indexPath = IndexPath(row: index, section: 0)
        let visibleIndexes = tableView?.indexPathsForVisibleRows ?? []
        
        if visibleIndexes.contains(indexPath) {
            DispatchQueue.main.async { [unowned self] in
                self.tableView?.beginUpdates()
                self.tableView?.reloadRows(at: [indexPath], with: .fade)
                self.tableView?.endUpdates()
            }
        }
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
        
        if let cell = cell as? MovieCell {
            setParallaxTo(cell: cell, at: indexPath)
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handlerDelegate?.moviesTableHandler(handler: self, didSelectItemAt: indexPath)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let indexPaths = tableView?.indexPathsForVisibleRows {
            for indexPath in indexPaths {
                guard let cell = tableView?.cellForRow(at: indexPath) as? MovieCell else { return }
                setParallaxTo(cell: cell, at: indexPath)
            }
        }
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
        
        let movie = handlerDelegate?.movies[indexPath.row]
        cell.imageLoader = imageLoader
        cell.selectionStyle = .none
        cell.update(movie: movie, at: indexPath)
        return cell
    }
    
    public func updateCell(at index:Int) {
        let indexPath = IndexPath(row: index, section: 0)
        
        tableView?.beginUpdates()
        tableView?.reloadRows(at: [indexPath], with: .fade)
        tableView?.endUpdates()
    }
    
    func setParallaxTo(cell:MovieCell, at indexPath:IndexPath) {
        guard let tableView = self.tableView else { return }
        
        let cellFrame = tableView.rectForRow(at: indexPath)
        let cellFrameInTable = tableView.convert(cellFrame, to: tableView.superview)
        let cellOffset = cellFrameInTable.origin.y + cellFrameInTable.size.height
        let tableHeight = tableView.bounds.height + cellFrameInTable.size.height
        let cellOffsetFactor = cellOffset / tableHeight
        cell.setParallax(percent: cellOffsetFactor)
    }
    
    func pullRefresh(sender:UIRefreshControl) {
        handlerDelegate?.moviesTableHandlerDidPullRefresh(handler: self)
    }
}
