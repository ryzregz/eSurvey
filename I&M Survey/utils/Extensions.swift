//
//  Extensions.swift
//  I&M Survey
//
//  Created by Morris on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import UIKit
typealias string = String


// MARK: - Methods
public extension UINavigationController {
    
    /// SwifterSwift: Pop ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completion: optional completion handler (default is nil).
    func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    /// SwifterSwift: Push ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - viewController: viewController to push.
    ///   - completion: optional completion handler (default is nil).
    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    /// SwifterSwift: Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    public func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
    
}

extension CATransition {
    func fadeTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        
        return transition
    }
}

extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
            
        case UIRectEdge.top:
            //
            border.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: thickness)
            
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0,  width: thickness, height: self.bounds.height)
        //
        case UIRectEdge.right:
            border.frame = CGRect(x: self.bounds.width - thickness, y: 0,  width: thickness, height: self.bounds.height)
        default:
            //
            border.frame = CGRect(x: 0, y: self.bounds.height - thickness,  width: self.bounds.width, height: thickness)
        }
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: AppFonts.getAppAttributedFont(.MEDIUM, withSize: 12)]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
    
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }

}

extension String{
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> Data? {
        let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters)
        return data
    }
}

extension String {
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    var isWhitespace: Bool {
        guard !isEmpty else { return true }
        
        let whitespaceChars = NSCharacterSet.whitespacesAndNewlines
        
        return self.unicodeScalars
            // The compiler (in Swift 4.0) required explicit types here. Future versions may let you get away with $0 implicit syntax
            .filter { (unicodeScalar: UnicodeScalar) -> Bool in !whitespaceChars.contains(unicodeScalar) }
            .count == 0
    }
    
    func versionToInt() -> [Int] {
        return self.components(separatedBy: ".")
            .map { Int.init($0) ?? 0 }
    }
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    func convertToDictionary() -> [String: String]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension Optional where Wrapped == String {
    
    var isNullOrWhitespace: Bool {
        return self?.isWhitespace ?? true
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        
        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}

extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    var deviceName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad Mini 5"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }
}

extension UIView {
    
    func getAllTextFields()-> [UITextField] {
        //
        return self.subviews.compactMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return view.getAllTextFields()
            }
            }.flatMap({$0})
    }
    
    func AddShadow(_ shadowLayer: CAShapeLayer, cornerRadius:CGFloat, fillColor:UIColor) -> CAShapeLayer{
        
        //
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        //
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
        
        layer.insertSublayer(shadowLayer, at: 0)
        
        return shadowLayer
    }
}

extension UIImage {
    var fixedOrientation: UIImage {
        guard imageOrientation != .up else { return self }
        
        var transform: CGAffineTransform = .identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform
                .translatedBy(x: size.width, y: size.height).rotated(by: .pi)
        case .left, .leftMirrored:
            transform = transform
                .translatedBy(x: size.width, y: 0).rotated(by: .pi)
        case .right, .rightMirrored:
            transform = transform
                .translatedBy(x: 0, y: size.height).rotated(by: -.pi/2)
        case .upMirrored:
            transform = transform
                .translatedBy(x: size.width, y: 0).scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        guard
            let cgImage = cgImage,
            let colorSpace = cgImage.colorSpace,
            let context = CGContext(
                data: nil, width: Int(size.width), height: Int(size.height),
                bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0,
                space: colorSpace, bitmapInfo: cgImage.bitmapInfo.rawValue
            )
            else { return self }
        context.concatenate(transform)
        
        var rect: CGRect
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            rect = CGRect(x: 0, y: 0, width: size.height, height: size.width)
        default:
            rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
        
        context.draw(cgImage, in: rect)
        return context.makeImage().map { UIImage(cgImage: $0) } ?? self
    }
        func toBase64() -> String? {
            guard let imageData = self.pngData() else { return nil }
            return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        }
    
}


