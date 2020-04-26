//
//  DefaultAppService.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import PluggableApplicationDelegate

final class DefaultAppService: NSObject, AppServices {
    //
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //
        if !ApiService.IsDevt {
            //1 Min
            application.setMinimumBackgroundFetchInterval(TimeInterval(floatLiteral: 60))
            
        }else{
            //Default
            application.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        }
        
        return true
    }
    
    
}
