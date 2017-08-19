//
//  DIctionary+UrlEncoder.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

extension Dictionary {
    func urlQuery(encoded:Bool = true) -> String {
        var itens : [String] = []
        
        for (key, value) in self {
            var encodedValue = "\(value)"
            var encodedKey = "\(key)"
            
            if encoded {
                encodedValue = encodedValue.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
                encodedKey = encodedKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
            }
            
            itens.append("\(encodedKey)=\(encodedValue)")
        }
        
        let result = itens.joined(separator: "&")
        return result
    }
}
