//
//  User.swift
//  AlamofirePractice
//
//  Created by kou yamamoto on 2021/02/09.
//

import Foundation

struct User: Codable {
    let id: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "profile_image_url" 
    }
}
