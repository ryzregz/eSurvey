//
//  CreateAccountVCViewController.swift
//  I&M Survey
//
//  Created by Eclectics on 22/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit
import SwiftyJSON
import ProgressHUD
import SwiftyJSON
import RealmSwift
class CreateAccountVC: DefaultViewController {
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var idNumberTextField: UITextField!
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
     @IBOutlet weak var profileButton: UIButton!
    var email = "",firstname = "", lastname = "", idnumber = "", phone = "", password = "", confirmpassword = ""
    var imagePicker : UIImagePickerController!
    var selected : UIImage!
     var image_has_value = false
    let api = ApiViewModel()
     let realm = try! Realm()
    var questions = [Question]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        api.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.getData()
        }
        
    }
    
    func getData(){
        let user_id = ""
        let surveyrequestData = SurveyService(survey_id: "1",user_id: user_id)
        let encodedLoginObject = try? JSONEncoder().encode(surveyrequestData)
        guard let surveyData = String(data: encodedLoginObject!, encoding: .utf8) else {
            return
        }
        Logger.Log(from: QuestionnairePageVC.self, with: "request data \(surveyData)")
        let requestJSON = JSON.init(parseJSON: surveyData)
        let request = Request(data: requestJSON)
        let encodedRequestObject = try? JSONEncoder().encode(request)
        guard let requestData = String(data: encodedRequestObject!, encoding: .utf8) else {
            return
        }
        DispatchQueue.main.async {
            self.api.listRequest(request:requestData,method: "product/questions")
        }
    }
    
    
    
    func setupViews(){
        if let emailImg = UIImage(named: "email_alt"),
           let profileImg = UIImage(named: "user"),
           let passImg = UIImage(named: "password (2)"),
           let phoneImg = UIImage(named: "phone-call"),
           let idImg = UIImage(named: "id-card"){
            emailTextField.setIcon(emailImg)
            firstNameTextField.setIcon(profileImg)
            lastNameTextField.setIcon(profileImg)
            passwordTextField.setIcon(passImg)
            confirmpasswordTextField.setIcon(passImg)
            phoneNumberTextField.setIcon(phoneImg)
            idNumberTextField.setIcon(idImg)
        }
        mainView.bringSubviewToFront(profileButton)
    }
    
    @IBAction func cameraAction(_ sender: UIButton) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
           //navigate()
        let validationResponse = validate()
        if(validationResponse == "true"){
            if(Reachability.isOnline()){
                sendApiRequest()
            }else{
                storeDataLocally()
            }

        }else{
              _ = SweetAlert().showAlert("Error!", subTitle: validationResponse,  style: AlertStyle.error, buttonTitle:"Ok", buttonColor:UIColor.red)
        }
        
        
    }
    
    
    func sendApiRequest(){
        Logger.Log(from: CreateAccountVC.self, with: "Sending API request")
        let registerrequestData = AuthService(firstname: firstname, lastname: lastname, email: email, password: password, phone_number: phone, id_number: idnumber, profile_image:TestData.getSampleImageString())
    
        let encodedLoginObject = try? JSONEncoder().encode(registerrequestData)
        guard let loginData = String(data: encodedLoginObject!, encoding: .utf8) else {
            return
        }
        Logger.Log(from: CreateAccountVC.self, with: "Create account data \(loginData)")
        let loginJSON = JSON.init(parseJSON: loginData)
        let request = Request(data: loginJSON)
        let encodedRequestObject = try? JSONEncoder().encode(request)
        guard let requestData = String(data: encodedRequestObject!, encoding: .utf8) else {
            return
        }
        ProgressHUD.show("Please wait ...")
        DispatchQueue.main.async {
            self.api.initiateRequest(request:requestData,method: "auth/register")
        }
        
        
    }
    
    
    func storeDataLocally(){
         Logger.Log(from: CreateAccountVC.self, with: "Writing data request")
       let userdata = User()
        userdata._Email = email
        userdata._UserFirstName = firstname
        userdata._UserLastName = lastname
        userdata._UserPhone = phone
        userdata._Thumb = selected.toBase64()!
        userdata._Password = password
        userdata._UserId = incrementID()
        
         DispatchQueue.main.async {
              DBManager.sharedInstance.addUser(object: userdata)
        }
        

    }
    
    
    
    // Generate auto-increment id manually
    private func incrementID() -> Int {
        return (realm.objects(User.self).max(ofProperty: "_UserId") as Int? ?? 0) + 1
    }
    
    
    func validate() -> String{
        var message = ""
        
        do {
             firstname = try firstNameTextField.validatedText(validationType: .requiredField(field: "First Name Address is Required"))
             lastname = try lastNameTextField.validatedText(validationType: .requiredField(field: "Last Name Address is Required"))
             email = try emailTextField.validatedText(validationType: .requiredField(field: "Email Address is Required"))
             email = try emailTextField.validatedText(validationType: ValidatorType.email)
             phone = try phoneNumberTextField.validatedText(validationType: .requiredField(field: "Mobile Number is Required"))
             idnumber = try idNumberTextField.validatedText(validationType: .requiredField(field: "ID/Passport Number is Required"))
             password = try passwordTextField.validatedText(validationType: .requiredField(field: "Password is Required"))
             confirmpassword = try confirmpasswordTextField.validatedText(validationType: .requiredField(field: "Password is Required"))
            message = "true"
        } catch(let error) {
            
            message = (error as! ValidationError).message
        }
        
        if(password != confirmpassword){
            message = "Password do not match"
        }
        if(!image_has_value){
            message = "Click the Photo Button to add a profile pic"
        }
        
        return message
    
    }
    
    func navigate(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "QuestionnairePageController") as? QuestionnairePageVC
        {
            vc.modalTransitionStyle = .flipHorizontal
            vc.questions = self.questions
            self.present(vc, animated: true)
        }
    }
    
    func navigatetoLogin(){
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        {
            vc.modalTransitionStyle = .partialCurl
            self.present(vc, animated: true)
        }
    }
    
    func saveUserKeys(data: JSON){
        ApiService.AppStore.updateValue(data["userid"].stringValue, forKey: UserKeys.KEY_USERID)
        ApiService.AppStore.updateValue(true, forKey: UserKeys.KEY_SIGNUP_COMPLETE)
    }
   

}


extension CreateAccountVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.selected = image.fixedOrientation
        self.profileImage.image = self.selected
        image_has_value = true
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateAccountVC : ApiCallInterface{
    func didRecieveResponse(response: JSON) {
        ProgressHUD.dismiss()
       
            if(response["data"].exists()){
                Logger.Log(from: CreateAccountVC.self, with: "Register Response \(response)")
                self.saveUserKeys(data: response["data"])
                let alert = UIAlertController(title: "Registration Successful", message: "Take a 1 minute survey to enable us serve you better", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "SKIP", style: UIAlertAction.Style.destructive, handler: { _ in
                             self.navigatetoLogin()
                }))
                alert.addAction(UIAlertAction(title: "TAKE SURVEY",
                                              style: UIAlertAction.Style.default,
                                              handler: {(_: UIAlertAction!) in
                                                
                                                self.navigate()
                }))
                self.present(alert, animated: true, completion: nil)
              
            }else{
                let responseString  = response.rawString()
                let decoder = JSONDecoder()
                do{
                    let question = try decoder.decode([Question].self, from: responseString!.data(using: .utf8)!)
                    self.questions.removeAll()
                    self.questions.append(contentsOf: question)
                    for q in question{
                        DispatchQueue.main.async {
                             DBManager.sharedInstance.addQuestions(object: q)
                        }
                    }
                  
                }catch{
                    print(error)
                }
                
            
            }
        
    }
    
    func didFailDataUpdateWithError(error: String) {
        ProgressHUD.dismiss()
        Logger.Log(from: CreateAccountVC.self, with: "Error Response \(error)")
        _ = SweetAlert().showAlert("Error!", subTitle: error,  style: AlertStyle.error, buttonTitle:"Ok", buttonColor:UIColor.red)
    }
    
}
