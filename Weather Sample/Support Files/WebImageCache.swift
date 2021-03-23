//
//  ImageCache.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 23/3/21.
//

import UIKit

struct WebImageCache {
    static private var imageCache = NSCache<NSString, UIImage>()
    
    static func getImage(forKey: URL) -> UIImage? {
        return imageCache.object(forKey: forKey.absoluteString as NSString)
    }
    
    static func save(image: UIImage, forKey key: URL){
        imageCache.setObject(image, forKey: key.absoluteString as NSString)
    }
}
