//
//  LoginVC.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit
import SwiftyJSON
import ProgressHUD
class LoginVC: DefaultViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let api = ApiViewModel()
    var email = "", password = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        api.delegate = self
    }
    
    func setupViews(){
         if let emailImg = UIImage(named: "email_alt"),
            let passImg = UIImage(named: "password (2)"){
            emailTextField.setIcon(emailImg)
            passwordTextField.setIcon(passImg)
        }
        
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        let validationResponse = validate()
        if(validationResponse == "true"){
            sendApiRequest()
        }else{
             _ = SweetAlert().showAlert("Error!", subTitle: validationResponse,  style: AlertStyle.error, buttonTitle:"Ok", buttonColor:UIColor.red)
        }
    }
    
    
    
    func validate() -> String{
        var message = ""
        do {
            email = try emailTextField.validatedText(validationType: .requiredField(field: "Mobile Number is Required"))
            
            password = try passwordTextField.validatedText(validationType: .requiredField(field: "Password is Required"))
            message = "true"
        } catch(let error) {
            
            message = (error as! ValidationError).message
        }
        
        return message
    }
    
    func sendApiRequest(){
        let loginrequestData = AuthService(email: email, password: password)
        
        let encodedLoginObject = try? JSONEncoder().encode(loginrequestData)
        guard let loginData = String(data: encodedLoginObject!, encoding: .utf8) else {
            return
        }
        Logger.Log(from: LoginVC.self, with: "Login data \(loginData)")
        let loginJSON = JSON.init(parseJSON: loginData)
        let request = Request(data: loginJSON)
        let encodedRequestObject = try? JSONEncoder().encode(request)
        guard let requestData = String(data: encodedRequestObject!, encoding: .utf8) else {
            return
        }
        ProgressHUD.show("Please wait ...")
        api.initiateRequest(request:requestData,method: "auth/login")
    }
    
    func navigate(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "HomeTabBar") as? HomeTabBarVC
        {
           self.show(vc, sender: self)
        }
    }


}
extension LoginVC: ApiCallInterface{
    func didRecieveResponse(response: JSON) {
        ProgressHUD.dismiss()
        Logger.Log(from: LoginVC.self, with: "Login Response \(response)")
        navigate()
    }
    
    func didFailDataUpdateWithError(error: String) {
        ProgressHUD.dismiss()
        Logger.Log(from: LoginVC.self, with: "Error Response \(error)")
         _ = SweetAlert().showAlert("Error!", subTitle: error,  style: AlertStyle.error, buttonTitle:"Ok", buttonColor:UIColor.red)
    }
    
    
}
