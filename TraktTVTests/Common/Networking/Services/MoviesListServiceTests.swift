//
//  MoviesListServiceTests.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import XCTest
@testable import TraktTV

class MoviesListServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCommonRequest() {
        let service = MovieListService(page: 1)
        let semaphore = DispatchSemaphore(value: 0)
        
        var movies : [Movie]?
        
        service.get { (result, headers) in
            if case RequestResult<[Movie]>.success(_, let content) = result {
                movies = content
            }
            
            semaphore.signal()
        }
        
        _ = semaphore.wait(timeout: DispatchTime.now() + .seconds(10))
        
        XCTAssert(movies != nil)
    }
    
}
