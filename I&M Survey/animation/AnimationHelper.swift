//
//  AnimationHelper.swift
//  I&M Survey
//
//  Created by Eclectics on 23/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import UIKit
struct AnimationHelper {
    static func yRotation(_ angle: Double) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    }
    
    static func perspectiveTransform(for containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
}
