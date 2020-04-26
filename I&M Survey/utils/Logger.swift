//
//  Logger.swift
//  I&M Survey
//
//  Created by Morris on 21/04/2020.
//  Copyright © 2020 Eclectics. All rights reserved.
//

import Foundation
import UIKit
class Logger{
    
    static func Log(from obj:AnyObject, with :String){
        //let message = #"String interpolation looks like this: \(with)."#
        if ApiService.IsDevt {
            //
            //os_log(" |:> ", log: log, "\(String(describing: type(of: obj))) |:> \(String(describing: with))")
            print("\(String(describing: type(of: obj))) |:> \(with)")
        }
        //print("\(String(describing: type(of: obj))) |:> \(with)")
    }
    
}
