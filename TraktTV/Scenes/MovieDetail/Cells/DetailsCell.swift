//
//  DetailsCell.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    @IBOutlet weak var taglineLabel     : UILabel!
    @IBOutlet weak var launchingLabel   : UILabel!
    @IBOutlet weak var runtimeLabel     : UILabel!
    @IBOutlet weak var ratingLabel      : UILabel!
    @IBOutlet weak var genresLabel      : UILabel!
    @IBOutlet weak var overviewLabel    : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DetailsCell {
    func update(movie:Movie?) {
        let info            = movie?.tmdbEntity
        taglineLabel.text   = info?.tagline
        runtimeLabel.text   = "\(info?.runtime ?? 0) minutos"
        ratingLabel.text    = String(info?.vote_average ?? 0.0)
        overviewLabel.text  = info?.overview
        
        updateLaunchingDate(movie: movie)
        updateGenres(movie: movie)
    }
    
    func updateLaunchingDate(movie:Movie?) {
        launchingLabel.text = nil
        
        if let dateString = movie?.tmdbEntity?.release_date {
            let components = dateString.components(separatedBy: "-")
            let date = components[2] + "/" + components[1] + "/" + components[0]
            launchingLabel.text = date
        }
    }
    
    func updateGenres(movie:Movie?) {
        genresLabel.text = nil
        
        if let genres = movie?.tmdbEntity?.genres {
            var genresString : [String] = []
            for genre in genres {
                genresString.append(genre.name ?? "")
            }
            genresLabel.text = genresString.joined(separator: ", ")
        }

    }
}
