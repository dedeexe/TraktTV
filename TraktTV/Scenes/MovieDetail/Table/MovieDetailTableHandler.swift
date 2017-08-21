//
//  MovieDetailTableHandler.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

public protocol MovieDetailTableHandlerDelegate : class {
    var movie:Movie? { get }
}

public class MovieDetailTableHandler : NSObject {
    
    weak var handlerDelegate : MovieDetailTableHandlerDelegate?
    weak var imageLoader : ImageLoader?
    weak var tableView : UITableView?
    
    public init(with imageLoader: ImageLoader?) {
        super.init()
        self.imageLoader = imageLoader
    }
    
    func setupTable(_ tableView:UITableView) {
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.black
        
        tableView.registerCell(named: String(describing:HeaderCell.self))
        tableView.registerCell(named: String(describing:DetailsCell.self))
    }
}

extension MovieDetailTableHandler : UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        self.tableView = tableView
        setupTable(tableView)
        return AppGenerics().justOne
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieDetailTableSection.count.rawValue
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == MovieDetailTableSection.details.rawValue {
            return createDetailsCell(in: tableView, with: handlerDelegate?.movie)
        }
        
        return createHeaderCell(in: tableView, with: handlerDelegate?.movie)
    }
    
}

extension MovieDetailTableHandler : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let headerCell = cell as? HeaderCell {
            headerCell.layoutSubviews()
            headerCell.setupShadowView()
        }
    }
}

// MARK: - Helpers
extension MovieDetailTableHandler {

    func createHeaderCell(in tableView:UITableView, with movie:Movie?) -> UITableViewCell {
        let identifier = String(describing:HeaderCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? HeaderCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell.imageLoader = imageLoader
        cell.selectionStyle = .none
        cell.update(movie: movie)
        return cell
    }
    
    func createDetailsCell(in tableView:UITableView, with movie:Movie?) -> UITableViewCell {
        let identifier = String(describing:DetailsCell.self)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DetailsCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell.selectionStyle = .none
        cell.update(movie: movie)
        return cell
    }
}
