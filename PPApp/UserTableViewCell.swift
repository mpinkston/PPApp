//
//  UserTableViewCell.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/23/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var portraitImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kanaLabel: UILabel!
    
    var user: User? = nil {
        didSet {
            render()
        }
    }
    
    func render() {
        if let image = user?.image1 ?? user?.image2 {
            portraitImage.image = UIImage(named: image)
        }
        nameLabel.text = user?.name
        kanaLabel.text = user?.kana
    }
}
