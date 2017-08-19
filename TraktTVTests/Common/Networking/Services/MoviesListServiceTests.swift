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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
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
        
        semaphore.wait(timeout: DispatchTime.now() + .seconds(10))
        
        XCTAssert(movies != nil)
    }
    
}
