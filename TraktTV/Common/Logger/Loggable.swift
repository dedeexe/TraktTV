//
//  Loggable.swift
//  Dede.exe
//
//  Created by Dede on 02/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import Foundation

public protocol Loggable {
    var defaultLoggingTag : LogTag { get }
    
    func log(level : LogLevel, _ message:@autoclosure ()->Any, _ path:String, function:String, line:Int)
    func log(level : LogLevel, tag:LogTag, _ message:@autoclosure ()->Any, path:String, function:String, line:Int)
}

public extension Loggable {
    func log(level : LogLevel, _ message:@autoclosure ()->Any, _ path:String=#file, function:String=#function, line:Int=#line) {
        log(level: level, tag: defaultLoggingTag, message, path: path, function: function, line: line)
    }
    
    func log(level : LogLevel, tag:LogTag, _ message:@autoclosure ()->Any, path:String, function:String, line:Int) {
        Logger.sharedInstance.log(level: level, tag: tag, className: String(describing:self), message: message, path, function, line: line)
    }
}
