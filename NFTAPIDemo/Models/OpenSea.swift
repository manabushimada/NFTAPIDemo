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

}

