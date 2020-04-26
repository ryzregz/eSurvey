//
//  CustomTextView.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import UIKit

class CustomTextView: UITextView {
    
    var bottomBorder = UIView()
    
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
        
        // Setup Bottom-Border
        self.translatesAutoresizingMaskIntoConstraints = false
        
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = .gray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        self.superview!.addSubview(bottomBorder)
        
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
    }
    
    func initialize() {
    }
    
}

private var borders = [UITextView: Bool]()

extension UITextView {
    
    @IBInspectable var showBottomBorder: Bool {
        get {
            guard let b = borders[self] else {
                return true
            }
            return b
        }
        set {
            borders[self] = newValue
            setUpBottomBorder()
        }
    }
    
    func setUpBottomBorder(){
        let border = UIView()
        
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = UIColor.gray
        self.addSubview(border)
        
        border.heightAnchor.constraint(equalToConstant: 1).isActive = true
        border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        border.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        border.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
