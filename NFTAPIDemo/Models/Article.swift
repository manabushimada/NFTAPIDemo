//
//  Article.swift
//  NFTAPIDemo
//
//  Created by Manabu Shimada on 01/08/2021.
//

import Foundation

struct Article: Codable {
    let title: String
    var user: User
    
    struct User: Codable {
        var name: String
    }
}
