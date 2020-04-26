//
//  SecurityCertificateManager.swift
//  I&M Survey
//
//  Created by Eclectics on 25/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import Alamofire
class SecurityCertificateManager {
    static let sharedInstance = SecurityCertificateManager()
    
    let defaultManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "http://35.235.64.188": .performDefaultEvaluation(validateHost: false)
        ]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
}
