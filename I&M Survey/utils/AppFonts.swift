//
//  AppFonts.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Eclectics. All rights reserved.
//

import Foundation
import UIKit
class AppFonts {
//
static let AppFontRegular = "Nunito-Regular"
static let AppFontBold = "Nunito-Bold"
static let AppFontItalic = "Nunito-Italics"
static let AppFontMedium = "Nunito-SemiBold"
//
static let FallBackFontRegular = "HelveticaNeue-Regular"
static let FallBackFontBold = "HelveticaNeue-Bold"
static let FallBackFontItalic = "HelveticaNeue-Italics"
static let FallBackFontMedium = "HelveticaNeue-Medium"
enum AppDisplayContext {
    case BOLD,MEDIUM,REGULAR,MESSAGE_BOLD,TITLE_BOLD,MESSAGE_REGULAR,TITLE_REGULAR,MESSAGE_SMALL,ERROR
}
//
static func getAppAttributedText(_ text:String, forContext:AppDisplayContext, withSize:CGFloat)
    ->NSAttributedString {
        //
        let font: [NSAttributedString.Key : NSObject]?
        //
        if let appFont =  UIFont(name: forContext == .BOLD ? AppFonts.AppFontBold : forContext == .MEDIUM ? AppFonts.AppFontMedium : AppFonts.AppFontRegular, size: withSize) {
            //
            font = [NSAttributedString.Key.font:appFont]
        }else{
            Logger.Log(from:self,with:"AppFOnts :: >> FAILED TO GET APP FONT FAMILY \(AppFonts.AppFontBold)")
            font = [NSAttributedString.Key.font:UIFont(name:AppFonts.FallBackFontBold, size: withSize)!]
        }
        //
        return NSMutableAttributedString(string: text, attributes: font)
}
//
static func getAppAttributedText(_ text:String, forContext:AppDisplayContext)
    ->NSAttributedString {
        //
        let font: [NSAttributedString.Key : NSObject]?
        //
        switch(forContext){
        case .TITLE_BOLD :
            if let appFont =  UIFont(name: AppFonts.AppFontBold, size: 18.0) {
                //
                font = [NSAttributedString.Key.font:appFont]
            }else{
                Logger.Log(from:self,with:"AppFOnts :: >> FAILED TO GET APP FONT FAMILY \(AppFonts.AppFontBold)")
                font = [NSAttributedString.Key.font:UIFont(name:AppFonts.FallBackFontBold, size: 18)!]
            }
        //
        case .TITLE_REGULAR :
            //
            if let appFont =  UIFont(name: AppFonts.AppFontRegular, size: 18.0) {
                //
                font = [NSAttributedString.Key.font:appFont]
            }else{
                font = [NSAttributedString.Key.font: UIFont(name: AppFonts.FallBackFontRegular, size: 18.0)!]
            }
            //
            break
        case .MESSAGE_BOLD:
            if let appFont =  UIFont(name: AppFonts.AppFontBold, size: 14.0) {
                //
                font = [NSAttributedString.Key.font:appFont]
            }else{
                //
                font = [NSAttributedString.Key.font: UIFont(name: AppFonts.FallBackFontBold, size: 14.0)!]
            }
            break
        case .MESSAGE_REGULAR:
            //
            if let appFont =  UIFont(name: AppFonts.AppFontBold, size: 14.0) {
                //
                font = [NSAttributedString.Key.font:appFont]
            }else{
                font = [NSAttributedString.Key.font: UIFont(name: AppFonts.FallBackFontBold, size: 14.0)!]
            }
            break
        case .MESSAGE_SMALL:
            //
            if let appFont =  UIFont(name: AppFonts.AppFontBold, size: 12.0) {
                //
                font = [NSAttributedString.Key.font:appFont]
            }else{
                font = [NSAttributedString.Key.font: UIFont(name: AppFonts.FallBackFontBold, size: 12.0)!]
            }
            break
        case .ERROR:
            //
            if let appFont =  UIFont(name: AppFonts.AppFontRegular, size: 12.0) {
                //
                font = [NSAttributedString.Key.font:appFont]
            }else{
                font = [NSAttributedString.Key.font: UIFont(name: AppFonts.FallBackFontRegular, size: 12.0)!,.foregroundColor:UIColor.red]
            }
            break
        @unknown default:
            //
            if let appFont =  UIFont(name: AppFonts.AppFontRegular, size: 14.0) {
                //
                font = [NSAttributedString.Key.font:appFont]
            }else{
                font = [NSAttributedString.Key.font: UIFont(name: AppFonts.FallBackFontRegular, size: 14.0)!]
            }
            break
        }
        return NSMutableAttributedString(string: text, attributes: font)
        
}

static func getAppAttributedFont(_ forContext:AppDisplayContext,withSize:CGFloat)
    ->UIFont {
        //
        switch(forContext){
        case .BOLD :
            //
            if let font = UIFont(name: AppFonts.AppFontBold, size: withSize) {
                return font
            }
            Logger.Log(from:self,with:"AppFOnts :: >> FAILED TO GET APP FONT FAMILY \(AppFonts.AppFontBold)")
            return UIFont(name: AppFonts.FallBackFontBold, size: withSize)!
        //
        case .MEDIUM:
            //
            if let font = UIFont(name: AppFonts.AppFontMedium, size: withSize) {
                return font
            }
            Logger.Log(from:self,with:"AppFOnts :: >> FAILED TO GET APP FONT FAMILY \(AppFonts.AppFontMedium)")
            return UIFont(name: AppFonts.FallBackFontMedium, size: withSize)!
        case .ERROR:
            //
            if let font = UIFont(name: AppFonts.AppFontRegular, size: withSize) {
                return font
            }
            Logger.Log(from:self,with:"AppFOnts :: >> FAILED TO GET APP FONT FAMILY \(AppFonts.AppFontRegular)")
            return  UIFont(name: AppFonts.FallBackFontRegular, size: withSize)!
        default:
            //
            if let font = UIFont(name: AppFonts.AppFontRegular, size: withSize) {
                return font
            }
            Logger.Log(from:self,with:"AppFOnts :: >> FAILED TO GET APP FONT FAMILY \(AppFonts.AppFontRegular)")
            return UIFont(name: AppFonts.FallBackFontRegular, size: withSize)!
        }
        
}
}
