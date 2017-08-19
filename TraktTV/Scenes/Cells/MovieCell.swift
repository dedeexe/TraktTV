//
//  CampaignCell.swift
//  Post2b
//
//  Created by Dede on 13/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import UIKit

public class MovieCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var nameLabel            : UILabel!
    @IBOutlet fileprivate weak var yearLabel            : UILabel!
    @IBOutlet fileprivate weak var shadowView           : UIView!
    @IBOutlet fileprivate weak var containerView        : UIView!
    
    @IBOutlet fileprivate weak var topImageSpacing      : NSLayoutConstraint!
    @IBOutlet fileprivate weak var bottomImageSpacing   : NSLayoutConstraint!
    fileprivate let paralaxFactor                       : CGFloat = 70.0
    fileprivate var initialSpacing                      : CGFloat = 0.0
    fileprivate var finalSpacing                        : CGFloat = 0.0
    
    fileprivate weak var imageLoader : ImageLoader?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        setupPriceLabel()
        setupYearLabel()
        setupShadowView()
        setupParallax()
    }
    
    func reload() {
        reloadPrice()
    }
    
    func inject(imageLoader:ImageLoader?) {
        self.imageLoader = imageLoader
    }
    
}

extension MovieCell {
    func loadImageBy(url:String?) {
        guard let url = url else {
            cellImage = nil
            return
        }
        
        imageLoader?.loadFrom(url: url) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(_, let fulfilledImage):
                        self?.campaignImage.image = fulfilledImage
                    case .fail:
                        self?.campaignImage.image = nil
                }
            }
        }
    }
    
    override public func prepareForReuse() {
        priceLabel.text = nil
        campaignImage.image = nil
        setupSocialLabels()
    }
}

// MARK: - Paralax
extension MovieCell {
    public func setParallax(percent:CGFloat) {
        let factor = max(0.0, min(1, percent))
        let moveOffset = (1 - factor) * paralaxFactor
        topImageSpacing.constant = initialSpacing - moveOffset
        bottomImageSpacing.constant = finalSpacing + moveOffset
    }
}

// MARK: - Configurations
extension MovieCell {

    func setupNameLabel() {
    }

    func setupYearLabel() {
    }
    
    func setupShadowView() {
        let gradient = CAGradientLayer()
        
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.40).cgColor,
            UIColor.black.withAlphaComponent(0.10).cgColor
        ]
        
        gradient.locations = [0.0, 1.0]
        gradient.frame = shadowView.layer.bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        shadowView.layer.addSublayer(gradient)
    }
    
    public override func layoutSubviews() {
        shadowView.layer.sublayers = nil
        setupShadowView()
    }
    
    func setupParallax() {
        bottomImageSpacing.constant -= paralaxFactor
        initialSpacing = topImageSpacing.constant
        finalSpacing = bottomImageSpacing.constant
    }
    
}

// MARK: - Refresh
extension MovieCell {
    
    func update(movie:Movie?) {
        nameLabel.text = movie?.title
        yearLabel.text = movie?.year
    }
    
}
