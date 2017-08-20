//
//  CampaignCell.swift
//  Dede.exe
//
//  Created by Dede on 13/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import UIKit

public class MovieCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var movieImage           : UIImageView!
    @IBOutlet fileprivate weak var nameLabel            : UILabel!
    @IBOutlet fileprivate weak var yearLabel            : UILabel!
    @IBOutlet fileprivate weak var shadowView           : UIView!
    @IBOutlet fileprivate weak var containerView        : UIView!
    
    @IBOutlet fileprivate weak var topImageSpacing      : NSLayoutConstraint!
    @IBOutlet fileprivate weak var bottomImageSpacing   : NSLayoutConstraint!
    fileprivate let paralaxFactor                       : CGFloat = 70.0
    fileprivate var initialSpacing                      : CGFloat = 0.0
    fileprivate var finalSpacing                        : CGFloat = 0.0
    fileprivate var indexPath                           : IndexPath = IndexPath(row: 0, section: 0)
    
    fileprivate var movie                               : Movie?
    
    public weak var imageLoader : ImageLoader?
        
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        setupNameLabel()
        setupYearLabel()
        setupShadowView()
        setupParallax()
    }
    
    func inject(imageLoader:ImageLoader?) {
        self.imageLoader = imageLoader
    }
    
}

extension MovieCell {
    func loadImageBy(url:String?) {
        guard let url = url else {
            movieImage.image = nil
            return
        }
        
        imageLoader?.loadFrom(url: url) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                    case .success(_, let fulfilledImage):
                        self?.movieImage.image = fulfilledImage
                    case .fail:
                        self?.movieImage.image = nil
                }
            }
        }
    }
    
    override public func prepareForReuse() {
        movieImage.image = nil
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

    func setupNameLabel() {}
    func setupYearLabel() {}
    
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
    func update(movie:Movie?, at indexPath:IndexPath) {
        self.indexPath = indexPath
        self.movie = movie
        
        nameLabel.text = movie?.title
        yearLabel.text = nil
        
        if let year = movie?.year {
            yearLabel.text = String(year)
        }
        
        updateImage()
    }
    
    func updateImage() {
        guard let _ = movie?.tmdbEntity?.poster_path else {
            self.loadImageBy(url: nil)
            return
        }
        
        guard let imageURL = URLImage().tmdb(for: self.movie) else {
            self.loadImageBy(url: nil)
            return
        }
        
        self.loadImageBy(url: imageURL)
    }
}
