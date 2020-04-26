//
//  ApiService.swift
//  I&M Survey
//
//  Created by Eclectics on 25/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class ApiService:NSObject{
    static var TAG:String = "Api Service "
    var app_id = ""
    var version_name = ""
    static var IsDevt:Bool{
        get{
            guard let config = AppDelegate.AppConfig, let env = config.environments.first(where: { (en) -> Bool in
                return en.active
            }) else{
                //Default ..
                return false
            }
            //
            return env.name.lowercased() == "development"
            
        }
    }
    //
    
    
    override init(){
        super.init()
        //
        if AppDelegate.AppConfig == nil {
            //Unit Tests ..
            do {
                //
                if let url = Bundle.main.url(forResource: "config", withExtension: "plist") {
                    //
                    let data = try Data(contentsOf: url)
                    //
                    var config = try PropertyListDecoder().decode(Config.self, from: data)

                    //
                    AppDelegate.AppConfig = config
                }
            }catch{
                Logger.Log(from:ApiService.self,with:"Config Error :: \(error)")
            }
            app_id = (AppDelegate.AppConfig?.headers.app_id)!
        }
     
    }
    
    static var AppStore:[String:Any]{
        get{
            if let userInformation = UserDefaults.standard.dictionary(forKey: Constants.DEFAULT_USER_STORE_KEY){
                //Old value
                return userInformation
            }else{
                //New Instance
                let userInfo = [String:Any]()
                //
                UserDefaults.standard.set(userInfo, forKey: Constants.DEFAULT_USER_STORE_KEY)
                //
                return userInfo
            }
        }
        set{
            //Overwrite
            UserDefaults.standard.set(newValue, forKey: Constants.DEFAULT_USER_STORE_KEY)
        }
    }
    
    
    static func sendApiRequest(request: String,method : String, onSuccess:@escaping (_ responseData: Data)->Void, onError: @escaping (_ errorMessage: Error?)->Void){
        let appid = AppDelegate.AppConfig?.headers.app_id
        let version_name = AppDelegate.AppConfig?.headers.version_name
        let headers: HTTPHeaders = [ "Content-type" : "application/json" , "app-id" : appid!, "version-name"  : version_name!]
        Logger.Log(from: ApiService.self, with: "Request \(request)")
        let  parameters : [String: Any] = request.toJSON() as! [String : Any]
        Logger.Log(from: ApiService.self, with: "Parameters \(parameters)")
          let url = RequestPaths(with:AppDelegate.AppConfig!).BASE_PATH + method
        SecurityCertificateManager.sharedInstance.defaultManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData {
            response in
            if let err = response.result.error {
                 Logger.Log(from: ApiService.self, with: "Failed to contact server \(err)")
                onError(response.result.error)
                return
            }
            guard let data = response.data else {return}
            
            onSuccess(data)
        }
        
    }
}
