//
//  DateFormatter.swift
//  2D Game
//
//  Created by Igor on 16.10.2023.
//

import Foundation

func currentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MM yyyy HH:mm"
    
    // Получаем текущую дату и время
    let currentDate = Date()
    
    // Преобразуем дату в строку в указанном формате
     return dateFormatter.string(from: currentDate)
}
