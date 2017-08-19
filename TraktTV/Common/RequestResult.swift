//
//  RequestResult.swift
//  dede.exe
//
//  Created by Dede on 31/05/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import Foundation

public enum RequestResult<T> {
    case success(Int, T)
    case fail(Int, Error)
}
