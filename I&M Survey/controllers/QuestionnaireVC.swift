//
//  OnboardingQuestionnaireVC.swift
//  I&M Survey
//
//  Created by Eclectics on 23/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit
import DLRadioButton
import SwiftyJSON
import ProgressHUD
class QuestionnaireVC: DefaultViewController {
     @IBOutlet weak var mainView : UIView!
     @IBOutlet weak var gender : UIView!
     @IBOutlet weak var expense : UIView!
     @IBOutlet weak var maritalstatus : UIView!
     @IBOutlet weak var profession : UIView!
     @IBOutlet weak var questionLabel : UILabel!
     @IBOutlet var forwardButton: UIButton!
     @IBOutlet var progressView: UIProgressView!
     @IBOutlet weak var positionLabel : UILabel!
    var index = 0
    var question = ""
    var no_of_answers = 0
    var type = ""
    var survey_id = 0
    var questionsSize = 0
    var loopSize  = 0
    var user_id = ""
    var answers = [Answer]()
    let radio = RadioGroup()
    let api = ApiViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        api.delegate = self
        guard let appStore = UserDefaults.standard.dictionary(forKey: Constants.DEFAULT_USER_STORE_KEY) else {
            return
        }
        
        user_id = appStore[UserKeys.KEY_USERID] as! String
    }
    
    func setupViews(){
        questionLabel.text = "\(index+1). \(question)"
        positionLabel.text = "\(index+1) of \(questionsSize)"
        progressView.progress = Float(index + 1)
        print("Question Size \(questionsSize)")
        print("Index \(index)")
         loopSize = questionsSize - 2
        switch type {
        case "gender":
            mainView.bringSubviewToFront(gender)
        case "expense":
            mainView.bringSubviewToFront(expense)
        case "maritalstatus":
            mainView.bringSubviewToFront(maritalstatus)
        case "profession":
            mainView.bringSubviewToFront(profession)
        default:
           mainView.bringSubviewToFront(gender)
        }
        
       
        
        switch index {
        case 0...loopSize: forwardButton.setTitle("NEXT", for: .normal)
        case questionsSize - 1: forwardButton.setTitle("SUBMIT", for: .normal)
        default: break
        }
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        switch index {
        case 0...loopSize:
            let pageViewController = parent as! QuestionnairePageVC
            pageViewController.forward(index: index)
            
        case questionsSize-1:
          submitAnswers()
        default: break
        }
        progressView.progress = Float(index + 1)
        positionLabel.text = "\(index+1) of \(questionsSize)"
    }
    
    
    func submitAnswers(){
        let encodedanswerObject = try? JSONEncoder().encode(answers)
        guard let answersData = String(data: encodedanswerObject!, encoding: .utf8) else {
            return
        }
        let answerJSON = JSON.init(parseJSON: answersData)
        let surveyrequestData = SurveyService(survey_id: "1", user_id:  user_id, answers: answerJSON)
        
        let encodedAnswerRequestObject = try? JSONEncoder().encode(surveyrequestData)
        guard let responsesData = String(data: encodedAnswerRequestObject!, encoding: .utf8) else {
            return
        }
        Logger.Log(from: QuestionnairePageVC.self, with: "Answers request data \(responsesData)")
        let requestJSON = JSON.init(parseJSON: responsesData)
        let request = Request(data: requestJSON)
        let encodedRequestObject = try? JSONEncoder().encode(request)
        guard let requestData = String(data: encodedRequestObject!, encoding: .utf8) else {
            return
        }
         Logger.Log(from: QuestionnairePageVC.self, with: "Request \(requestData)")
         ProgressHUD.show("Please wait ...")
        DispatchQueue.main.async {
            self.api.initiateRequest(request:requestData,method: "product/addResponse")
        }
      
    }
    
    func navigatetoLogin(){
         ApiService.AppStore.updateValue(true, forKey: UserKeys.KEY_QUESTINNAIRE_DONE)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        {
            vc.modalTransitionStyle = .partialCurl
            self.present(vc, animated: true)
        }
    }

}
extension QuestionnaireVC: ApiCallInterface{
    func didRecieveResponse(response: JSON) {
           ProgressHUD.dismiss()
        
        let alert = UIAlertController(title: "Survey Completed Successfully", message: "Tnak you", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "DONE",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
                                        
                                        self.navigatetoLogin()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func didFailDataUpdateWithError(error: String) {
           ProgressHUD.dismiss()
        
    }
    
    
}



