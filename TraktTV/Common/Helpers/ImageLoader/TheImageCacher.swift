//
//  TheImageCacher.swift
//  TraktTV
//
//  Created by dede.exe on 21/08/17.
//  Copyright © 2017 dede.exe. All rights reserved.
//

import UIKit

public class TheImageCacher {
    
    public static let shared : TheImageCacher = TheImageCacher()
    
    fileprivate var cache : NSCache<NSString, UIImage>
    
    fileprivate init() {
        cache = NSCache()
        cache.name = "TheImageCacher"
        cache.countLimit = 150
        cache.totalCostLimit = 150
    }
    
    func getImage(named:String) -> UIImage? {
        guard let image = cache.object(forKey: named as NSString) else { return nil }
        return image
    }
    
    func setImage(_ image:UIImage, forKey key:String) {
        cache.setObject(image, forKey: key as NSString, cost: 1)
    }
    
}
