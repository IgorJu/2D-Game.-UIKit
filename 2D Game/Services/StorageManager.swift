//
//  StorageManager.swift
//  2D Game
//
//  Created by Igor on 24.09.2023.
//

import UIKit

final class StorageManager{
    
    static let shared = StorageManager()
    
    //MARK: Работа с именем
    func saveUser(name: String) {
        UserDefaults.standard.set(name, forKey: "usernameKey")
    }
    
    func loadUserName(_ name: UILabel) {
        if let username = UserDefaults.standard.string(forKey: "usernameKey") {
            name.text = username
        }
    }
    
    //MARK: Работа с аватаром пользователя
    func saveImageToUserDefaults(image: UIImage) {
        if let imageData = image.pngData() {
            UserDefaults.standard.set(imageData, forKey: "userPhoto")
        }
    }
    
    func loadUserPhoto(imageView: UIImageView) {
        if let imageData = UserDefaults.standard.data(forKey: "userPhoto"),
           let userPhoto = UIImage(data: imageData) {
            imageView.image = userPhoto
        }
    }

    
    
    
    private init() {}
}
