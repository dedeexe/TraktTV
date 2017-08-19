//
//  Gettable.swift
//  dede.exe
//
//  Created by Dede on 02/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import Foundation

public protocol Gettable {
    associatedtype DataType
    func get(completion: @escaping (RequestResult<DataType>, [String:Any]) -> Void)
}
