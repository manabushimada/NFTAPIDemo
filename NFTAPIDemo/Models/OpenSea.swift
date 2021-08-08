//
//  OpenSea.swift
//  NFTAPIDemo
//
//  Created by Manabu Shimada on 02/08/2021.
//

import Foundation

struct OpenSea: Codable {
    
   let assets: Assets
    
    
}

struct Assets: Codable {
    let name: String
    let id: Int
    let imageUrl: String
    let permalink: String
    
    init(name: String, id: Int, image_url: String, permalink: String) {
        self.name = name
        self.id = id
        self.imageUrl = image_url
        self.permalink = permalink
    }

}

