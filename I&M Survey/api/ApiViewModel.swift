//
//  ApiInterface.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import SwiftyJSON
protocol ApiCallInterface:class {
    func didRecieveResponse(response: JSON)
    func didFailDataUpdateWithError(error: String)
}

class ApiViewModel: NSObject{
     weak var delegate: ApiCallInterface?
    
    func initiateRequest(request : String,method: String){
        ApiService.sendApiRequest(request: request, method: method, onSuccess: { data in
            let res  = JSON(data)
            Logger.Log(from: ApiViewModel.self, with: "API RESPONSE \(res)")
            self.setResponse(response: data)
            
        }) { (error) in
            Logger.Log(from: ApiViewModel.self, with: "API ERROR \(error.debugDescription)")
            self.delegate?.didFailDataUpdateWithError(error: error.debugDescription)
        }
    }
    
    func setResponse(response: Data){
        let d  = JSON(response)
         Logger.Log(from: ApiViewModel.self, with: "JSON RESPONSE \(d)")
        let response_code = d["code"].intValue
        if response_code == 1001{
             self.delegate?.didRecieveResponse(response:  d)
        }else{
             let response_message = d["message"].stringValue
             self.delegate?.didFailDataUpdateWithError(error: response_message)
        }
       
    }
    
    func listRequest(request : String, method : String){
        ApiService.sendApiRequest(request: request, method: method, onSuccess: { data in
            self.setListResponse(response: data)
            
        }) { (error) in
            print("API ERROR \(error.debugDescription)")
            self.delegate?.didFailDataUpdateWithError(error: error!.localizedDescription)
        }
    }
    
    func setListResponse(response: Data){
        let d : JSON = JSON(response)
        let response_code = d["code"].intValue
        if response_code == 1001{
            let data : JSON = JSON(d["data"])
            self.delegate?.didRecieveResponse(response: data)
        }else{
            let response_message = d["message"].stringValue
            self.delegate?.didFailDataUpdateWithError(error: response_message)
        }
        // print("JSON DATA RESPONSE \(jsonResponse)")
    }
}
