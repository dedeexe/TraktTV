//
//  RequestEncoding.swift
//  dede.exe
//
//  Created by Dede on 31/05/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import Foundation

public enum RequestEncoding : String {
    case url
    case json
    case httpBody
}

extension RequestEncoding {
    var contentType : String {
        switch self {
            case .json              : return "application/json"
            case .url, .httpBody    : return ""
        }
    }
}
