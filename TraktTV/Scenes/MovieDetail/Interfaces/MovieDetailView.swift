//
//  MovieDetailView.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

public protocol MovieDetailView : class {
    func show(movie:Movie?)
}
