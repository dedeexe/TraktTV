//
//  RequestHeader.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation

public struct RequestHeader {
    
    private var request : URLRequest
    
    public init(from request: URLRequest) {
        self.request = request
    }
    
    public func dump(pretty:Bool = true) -> String {
        
        guard let  headerFields = request.allHTTPHeaderFields else {
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
