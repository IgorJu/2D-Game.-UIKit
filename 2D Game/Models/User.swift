//
//  User.swift
//  2D Game
//
//  Created by Igor on 12.10.2023.
//

import Foundation

struct User: Codable {
    let name: String
    let record: Record
    let imageName: String
    var data = currentDate()
}
