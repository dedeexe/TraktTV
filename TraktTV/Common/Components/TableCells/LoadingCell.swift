//
//  LoadingCell.swift
//  Dede.exe
//
//  Created by dede.exe on 23/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import UIKit

public class LoadingCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var loading : UIActivityIndicatorView!
    
    public init() {
        let identifier = String(describing: LoadingCell.self)
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func startLoadingAnimation() {
        loading.startAnimating()
    }

    public func stopLoadingAnimation() {
        loading.stopAnimating()
    }
}
