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
    
    let currentDate = Date()
    
     return dateFormatter.string(from: currentDate)
}
