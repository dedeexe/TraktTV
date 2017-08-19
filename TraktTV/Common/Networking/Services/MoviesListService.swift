//
//  MovieListService.swift
//  TraktTV
//
//  Created by dede.exe on 19/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation
import ObjectMapper

public struct MovieListService : Gettable, Loggable {
    
    public typealias DataType = [Movie]
    public var defaultLoggingTag: LogTag = .service
    
    fileprivate var page             : Int = 0
    fileprivate var pageSize         : Int = 40
    
    public init(page:Int, pageSize:Int=40) {
        self.page = page
        self.pageSize = pageSize
    }
    
    public func get(completion: @escaping (RequestResult<DataType>, [String:Any]) -> Void) {
        
        let requestInfo = MoviesEndpoint.getMovies(page: page, size: pageSize)
        
        let headers = HeaderCreator().standard
        
        WebService.instance.request(request: requestInfo, additionalHeaders: headers) { result, headers in            
            switch result {
                case .fail(let code, let err):
                    completion(RequestResult<DataType>.fail(code, err), headers)
                    
                case .success(let code, let json):
                    
                    let data = (json ?? "").data(using: .utf8) ?? Data()
                    guard let jsonArray = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:AnyObject]] else {
                        let error = NSError(domain: "Fail to convert json", code:1000, userInfo: nil)
                        completion(RequestResult<DataType>.fail(1000, error), headers)
                        return
                    }
                    
                    let movies = Mapper<Movie>().mapArray(JSONArray: jsonArray ?? []) ?? []
                    completion(RequestResult<DataType>.success(code, movies), headers)
            }
        }
    }
}
