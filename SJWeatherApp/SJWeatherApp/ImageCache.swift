//
//  ImageCache.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 29/08/23.
//

import UIKit

class ImageCache: ObservableObject {
    private let cache = NSCache<NSString, UIImage>()
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

