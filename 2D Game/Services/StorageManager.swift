//
//  StorageManager.swift
//  2D Game
//
//  Created by Igor on 24.09.2023.
//

import UIKit


final class StorageManager {
    
    static let shared = StorageManager()
    
    //MARK: - Работа cо строками
    
    func saveString(_ string: String, key: String) {
        UserDefaults.standard.set(string, forKey: key)
    }
    
    func loadString(key: String) -> String? {
        guard let text = UserDefaults.standard.object(forKey: key) as? String else { return nil }
        return text
    }
    
    //MARK: - Работа с аватаром пользователя
    
    func saveImage(_ image: UIImage) -> String? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileName = UUID().uuidString
        let fileURL = documentsDirectory.appending(path: fileName)
        
        guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch {
            return nil
        }
}
    
    func loadImage(name: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = documentsDirectory.appending(component: name)
        
        let image = UIImage(contentsOfFile: fileURL.path())
        return image
    }
    
    //MARK: - Работа с рекордами пользователя
    
    func saveRecords(_ records: [User]) {
        UserDefaults.standard.set(encodable: records, forKey: .records)
    }
    
    func loadRecords() -> [User]? {
        guard let users = UserDefaults.standard.object([User].self, forKey: .records) else { return []}
                return users
    }
    
    //MARK: - Работа со скоростью игры
    
    func saveDouble(_ number: Double, key: String) {
        UserDefaults.standard.set(number, forKey: key)
    }
    
    func loadDouble(key: String) -> Double? {
        guard let number = UserDefaults.standard.object(forKey: key) as? Double else { return nil }
        return number
    }

    private init() {}
}

//MARK: - Extension for encode, decode <T>

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func object<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
          return nil
    }
}
