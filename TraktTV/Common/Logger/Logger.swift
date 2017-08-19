//
//  P2BLog.swift
//  Post2b
//
//  Created by Dede on 02/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import Foundation

protocol LoggerType {
    func log(level : LogLevel, tag:LogTag, className:String, message:@autoclosure ()->Any, _ path:String, _ function:String, line:Int)
}

final public class Logger {
    
    var activeLogger: LoggerType?
    var distabledSymbols = Set<String>()
    private(set) static var sharedInstance = Logger()
    
    public static let shared : Logger = Logger()
    private init() {}
    
    static func setSharedInstance(logger:Logger) {
        sharedInstance = logger
    }
    
    func setupLogger(logger:LoggerType) {
        assert(activeLogger == nil, "Change logger is not allowed to maintain consistency")
        activeLogger = logger
    }
    
    func ignoreClass(type:Any) {
        distabledSymbols.insert(String(describing: type))
    }
    
    func ignoreTag(tag: LogTag) {
        distabledSymbols.insert(tag.rawValue)
    }
    
    func log(level:LogLevel, tag:LogTag, className:String, message:@autoclosure ()->Any, _ path:String, _ function: String, line:Int) {
        guard logAllowed(tag: tag, className: className) else { return }
        activeLogger?.log(level: level, tag: tag, className: className, message: message, path, function, line: line)
    }
    
    private func logAllowed(tag: LogTag, className:String) -> Bool {
        return !distabledSymbols.contains(className) && !distabledSymbols.contains(tag.rawValue)
    }
    
}
