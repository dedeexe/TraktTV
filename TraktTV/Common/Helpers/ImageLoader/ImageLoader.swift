//
//  ImageLoader.swift
//  Dede.exe
//
//  Created by dede.exe on 05/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import UIKit

public protocol ImageLoader : class {
    func loadFrom(url:String, completion:@escaping (RequestResult<UIImage>) -> Void)
}
