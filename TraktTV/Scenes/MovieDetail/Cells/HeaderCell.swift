//
//  HeaderCell.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var movieImage           : UIImageView!
    @IBOutlet fileprivate weak var nameLabel            : UILabel!
    @IBOutlet fileprivate weak var yearLabel            : UILabel!
    @IBOutlet fileprivate weak var shadowView           : UIView!
    @IBOutlet fileprivate weak var containerView        : UIView!
    
    public weak var imageLoader : ImageLoader?
    fileprivate var movie       : Movie?

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup() {
        self.containerView.layoutIfNeeded()
        self.containerView.layoutSubviews()
    }
    
}

extension HeaderCell {
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


// MARK: - Configurations
extension HeaderCell {
    func setupShadowView() {
        
        shadowView.layer.sublayers?.removeAll()
        
        self.shadowView.translatesAutoresizingMaskIntoConstraints = false;
        
        let gradient = CAGradientLayer()
        
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.0).cgColor,
            UIColor.black.withAlphaComponent(1.0).cgColor
        ]
        
        gradient.locations = [0.0, 1.0]
        gradient.frame = shadowView.layer.bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        shadowView.layer.addSublayer(gradient)
    }
}

extension HeaderCell {
    func update(movie:Movie?) {
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
