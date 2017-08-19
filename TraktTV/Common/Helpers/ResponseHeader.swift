//
//  ResponseHeader.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public struct HTTPResponseHeader {
    
    private var response : HTTPURLResponse
    
    public init(from response: HTTPURLResponse) {
        self.response = response
    }
    
    public func dump(pretty:Bool = true) -> String {
        
        guard let headerFields = response.allHeaderFields as? [String:String] else {
            return ""
        }
        
        var fields : [String] = []
        
        for (key, value) in headerFields {
            let result =  "\(key) : \(value)"
            fields.append(result)
        }
        
        let separator = pretty ? "\n" : " , "
        let result = fields.joined(separator: separator)
        return result
        
    }
    
}
