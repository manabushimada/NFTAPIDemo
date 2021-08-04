//
//  NFTTableViewCell.swift
//  NFTAPIDemo
//
//  Created by Manabu Shimada on 03/08/2021.
//

import UIKit
import Nuke

class NFTTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func set(title: String, author: String, imageUrl: String) {
        Nuke.loadImage(with: URL(string: imageUrl)!, into: iconImageView)
        titleLabel.text = title
        authorLabel.text = author
    }
    
    
    
}

