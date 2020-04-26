//
//  RequestPaths.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
class RequestPaths{
    public var DEVT_PATH = ""
    
    public var ROOT_PATH = ""
    
    public var BASE_PATH = ""
    
    public var TOKEN_PATH = "/token"
    
    init(with config:Config){
        //
        guard let env = config.environments.first(where: { (en) -> Bool in
            return en.active
        }) else{
            Logger.Log(from:self as AnyObject,with:"Could not read config..")
            return
        }
        
        //
        ROOT_PATH = env.rootURL
        BASE_PATH = "\(ROOT_PATH)\(env.endPoint)"
        //
        Logger.Log(from:self as AnyObject,with:"Current BASE URL => \(BASE_PATH)")
    }
}

