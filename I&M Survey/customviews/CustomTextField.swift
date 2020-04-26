//
//  CustomTextField.swift
//  I&M Survey
//
//  Created by Eclectics on 22/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class CustomTextField : UITextField
{
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        } }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}
