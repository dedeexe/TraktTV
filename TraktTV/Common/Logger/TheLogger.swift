//
//  P2BLogger.swift
//  Dede.exe
//
//  Created by Dede on 02/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import Foundation

public class TheLogger : LoggerType {
    
    func log(level: LogLevel, tag: LogTag, className: String, message: @autoclosure () -> Any, _ path: String, _ function: String, line: Int) {
        let msg = message() as? String ?? ""
        let logString = "[\(level)][\(className):\(line)] - \(msg)"
        NSLog(logString)
    }
    
}
