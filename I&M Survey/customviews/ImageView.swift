//
//  ImageView.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit

@IBDesignable
extension UIImageView
{
    private struct AssociatedKey
    {
        static var roundedTop = "UIImageView.roundedTop"
    }
    
    @IBInspectable var roundedTop: Bool
        {
        get
        {
            if let roundedTop = objc_getAssociatedObject(self, &AssociatedKey.roundedTop) as? Bool
            {
                return roundedTop
            }
            else
            {
                return false
            }
        }
        set
        {
            objc_setAssociatedObject(self, &AssociatedKey.roundedTop, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        //
        if roundedTop {
            //layer.cornerRadius = 20
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath
            //self.layer.backgroundColor = UIColor.green.cgColor
            self.layer.mask = rectShape
        }
    }
}

class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        //
        
    }
}

class CellRoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = max(self.bounds.size.width,self.bounds.size.height) / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
        //
        self.layer.borderWidth = 1.5
        self.layer.borderColor = GlobalVariables.colorAccent.cgColor
    }
}

extension UIImage {
    //
    func imageWithBorder(width: CGFloat, color: UIColor) -> UIImage? {
        let square = CGSize(width: min(size.width, size.height) + width * 2, height: min(size.width, size.height) + width * 2)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .center
        imageView.image = self
        imageView.layer.borderWidth = width
        imageView.layer.borderColor = color.cgColor
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

extension UIImage {
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    //
    func rounded(with color: UIColor, width: CGFloat) -> UIImage? {
        let bleed = breadthRect.insetBy(dx: -width, dy: -width)
        UIGraphicsBeginImageContextWithOptions(bleed.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(
            x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : 0,
            y: isPortrait  ? ((size.height-size.width)/2).rounded(.down) : 0),
                                                         size: breadthSize))
            else { return nil }
        UIBezierPath(ovalIn: CGRect(origin: .zero, size: bleed.size)).addClip()
        var strokeRect =  breadthRect.insetBy(dx: -width/2, dy: -width/2)
        strokeRect.origin = CGPoint(x: width/2, y: width/2)
        UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation).draw(in: strokeRect.insetBy(dx: width/2, dy: width/2))
        color.set()
        let line = UIBezierPath(ovalIn: strokeRect)
        line.lineWidth = width
        line.stroke()
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
extension UIImage {
    func roundedWithBorder(width: CGFloat, color: UIColor) -> UIImage? {
        let square = CGSize(width: min(size.width, size.height) + width * 2, height: min(size.width, size.height) + width * 2)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .center
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = width
        imageView.layer.borderColor = color.cgColor
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

