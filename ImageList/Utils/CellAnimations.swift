//
//  CellAnimations.swift
//  ImageList
//
//  Created by Xie Liwei on 06/04/2019.
//  Copyright © 2019 Xie Liwei. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

let CellAnimatorStartTransform: CATransform3D = {
    let rotationDegrees: CGFloat = -15.0
    let rotationRadians: CGFloat = rotationDegrees * (CGFloat(Double.pi)/180.0)
    let offset = CGPoint(x: -20, y: -20)
    var startTransform = CATransform3DIdentity
    startTransform = CATransform3DRotate(CATransform3DIdentity,
                                         rotationRadians, 0.0, 0.0, 1.0)
    startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
    
    return startTransform
}()

class CellAnimator {
    class func animateDropIn(cell: UITableViewCell) {
        let view = cell.contentView
        
        view.layer.transform = CellAnimatorStartTransform
        view.layer.opacity = 0
        
        UIView.animate(withDuration: 0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
}
