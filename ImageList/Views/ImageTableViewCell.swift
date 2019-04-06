//
//  ImageTableViewCell.swift
//  ImageList
//
//  Created by Xie Liwei on 06/04/2019.
//  Copyright © 2019 Xie Liwei. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageToTopConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
