//
//  P2BImageDownloader.swift
//  Dede.exe
//
//  Created by dede.exe on 15/06/17.
//  Copyright © 2017 Dede. All rights reserved.
//

import UIKit

public class TheImageDownloader : ImageLoader {
    
    public static let shared : TheImageDownloader = TheImageDownloader()
    
    fileprivate init() {}
    
    public func loadFrom(url:String, completion:@escaping (RequestResult<UIImage>) -> Void) {
        
        if let image = TheImageCacher.shared.getImage(named: url) {
            completion(RequestResult<UIImage>.success(200, image))
            return
        }
        
        guard let urlString = URL(string: url) else {
            let err = NSError(domain: "Image Loader - Invalid URL", code: 1000, userInfo: nil)
            completion(RequestResult.fail(1000, err))
            return
        }
        
        URLSession.shared.dataTask(with: urlString) { (data, _, error) in
            
            if let error = error {
                completion(RequestResult.fail(1000, error))
                return
            }
            
            guard let newData = data, let image = UIImage(data: newData) else {
                let err = NSError(domain: "Image Loader - No image present", code: 1000, userInfo: nil)
                completion(RequestResult.fail(1000, err))
                return
            }
            
            TheImageCacher.shared.setImage(image, forKey: url)
            completion(RequestResult<UIImage>.success(200, image))
            
        }.resume()
        
    }
    
}
