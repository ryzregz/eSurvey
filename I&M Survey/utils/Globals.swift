//
//  Globals.swift
//  I&M Survey
//
//  Created by Morris on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import UIKit

struct GlobalVariables {
    //primary
    static let colorPrimary = UIColor(named:"colorPrimary") ?? UIColor(red: 248.0/255.0, green: 141.0/255, blue: 43.0/255.0, alpha: 1.0)
    //primaryDark#ff005655
    static let colorPrimaryDark = UIColor(named:"colorPrimaryDark") ?? UIColor(red: 255.0/255, green: 110.0/255, blue: 0.0/255, alpha:1.0)
    //#fff15a23
    static let colorAccent = UIColor(named:"colorAccent") ?? UIColor(red: 41.0/255, green: 158.0/255, blue: 155.0/255, alpha: 1.0)
    //    <gradient android:type="linear" android:useLevel="true" android:startColor="#ff005655" android:endColor="#33f15a23" android:angle="135" />
    static let colorFormBG = UIColor(named: "colorFormBackground") ?? .white
    static let colorTextBlack = UIColor(named: "colorTextBlack") ?? .black
    static let colorTextAccent = UIColor(named: "colorTextAccent") ?? GlobalVariables.colorAccent
    static let colorTextPrimary = UIColor(named: "colorTextPrimary") ?? GlobalVariables.colorPrimary
    static let colorTextWhite = UIColor(named: "colorTextWhite") ?? .white
    
    static let AppGradient: CAGradientLayer = {
        //Gradiant for the background view
        let bottom = UIColor(named:"colorAppBarGradientBottom")?.cgColor ?? UIColor(red: 85/255, green: 26/255, blue: 139/255, alpha: 1.0).cgColor
        let center = UIColor(named:"colorAppBarGradientCenter")?.cgColor ?? UIColor(red: 162/255, green: 58/255, blue: 90/255, alpha: 0.8).cgColor
        //
        let top = UIColor(named:"colorAppBarGradientTop")?.cgColor ?? UIColor(red: 245/255, green: 90/255, blue: 35/255, alpha: 0.4).cgColor
        //
        let gradiant = CAGradientLayer()
        gradiant.colors = [top, center,bottom]
        gradiant.locations = [0.0,0.5,1.0]
        //
        //gradiant.startPoint = CGPoint(x: 0.25, y: 0.25)
        //gradiant.endPoint = CGPoint(x: 1.0, y: 1.0)
        //
        return gradiant
    }()
    static let OnbaordingGradient :CAGradientLayer = {
        let gradientLayer0 = CAGradientLayer()
        let start = UIColor(named:"colorOnboardingGradientStart")?.cgColor ?? UIColor(red: 0.00, green: 0.34, blue: 0.33, alpha: 1).cgColor
        let end = UIColor(named:"colorOnboardingGradientEnd")?.cgColor ?? UIColor(red: 0.95, green: 0.35, blue: 0.14, alpha: 0.20).cgColor
        //gradientLayer0.frame = style.bounds
        gradientLayer0.colors = [start, end]
        gradientLayer0.locations = [1, 0]
        //
        return gradientLayer0
    }()
    static let BarGradient: CAGradientLayer = {
        //Gradiant for the background view
        let start = colorPrimary.cgColor
        let end = colorPrimaryDark.cgColor
        //
        let gradiant = CAGradientLayer()
        gradiant.colors = [start, end]
        gradiant.locations = [0.0,0.5,1.0]
        //
        gradiant.startPoint = CGPoint(x: 0, y: 0.5)
        gradiant.endPoint = CGPoint(x: 1.0, y: 0.5)
        //
        return gradiant
    }()
    //Height with respect to iPhone 6
    static let screenHeightRatio = UIScreen.main.bounds.height / 736
    //Width ratio with respect to iPhone 6
    static let screenWidthRatio = UIScreen.main.bounds.width / 414
    
}

struct Constants{
    static let DEFAULT_USER_STORE_KEY = "userInformation"
}
