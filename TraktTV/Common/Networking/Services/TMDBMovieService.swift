//
//  TMDBMovieService.swift
//  TraktTV
//
//  Created by dede.exe on 20/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import Foundation
import ObjectMapper

public struct TMDBMovieService : Gettable, Loggable {
    
    public typealias DataType = TMDBEntity
    public var defaultLoggingTag: LogTag = .service
    
    fileprivate var id  : Int = 0
    
    public init(id: Int) {
        self.id = id
    }
    
    public func get(completion: @escaping (RequestResult<DataType>, [String:Any]) -> Void) {
        
        let requestInfo = MoviesEndpoint.getMovie(id: id)
        
        let headers = HeaderCreator().tmdb
        
        WebService.instance.request(request: requestInfo, additionalHeaders: headers) { result, headers in
            switch result {
                case .fail(let code, let err):
                    completion(RequestResult<DataType>.fail(code, err), headers)
                    
                case .success(let code, let json):
                    let movie = Mapper<TMDBEntity>().map(JSONString: json ?? "") ?? TMDBEntity()
                    completion(RequestResult<DataType>.success(code, movie), headers)
            }
        }
    }
}
