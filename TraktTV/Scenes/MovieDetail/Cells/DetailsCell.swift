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
        
    }
}
