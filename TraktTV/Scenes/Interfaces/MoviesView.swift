//
//  MoviesView.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

public protocol MoviesView : class, Alertable {
    func show(movies:[Movie])
}
