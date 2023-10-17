//
//  ImageManager.swift
//  2D Game
//
//  Created by Igor on 17.10.2023.
//

import UIKit

final class ImageManager {
    
    private var images = [String: UIImage]()
    
    static let shared = ImageManager()
    
    private init() {}
    
    func getImage(key: String) -> UIImage? {
        if let image = images[key] {
            return image
        }
        
        let image = StorageManager.shared.loadImage(name: key)
        images[key] = image
        return image
    }
}
