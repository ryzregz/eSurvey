//
//  HomeVC.swift
//  I&M Survey
//
//  Created by Eclectics on 26/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit
import SwiftyJSON
import ProgressHUD
class HomeVC: DefaultViewController {
    @IBOutlet weak var tableView : UITableView!
    var surveys = [Survey]()
    let api = ApiViewModel()
    var user_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         api.delegate = self
         tableView.delegate = self
         tableView.dataSource = self
        
        guard let appStore = UserDefaults.standard.dictionary(forKey: Constants.DEFAULT_USER_STORE_KEY) else {
            return
        }
        
        user_id = appStore[UserKeys.KEY_USERID] as! String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    
    func loadData(){
        let surveyrequestData = SurveyService(survey_id: "", user_id: user_id)
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
        ProgressHUD.show("Loading..")
        DispatchQueue.main.async {
            self.api.listRequest(request:requestData,method: "product/mysurveys")
        }
    }
    


}
extension HomeVC: ApiCallInterface{
    func didRecieveResponse(response: JSON) {
        ProgressHUD.dismiss()
        
        let responseString  = response.rawString()
        let decoder = JSONDecoder()
        do{
            let survey = try decoder.decode([Survey].self, from: responseString!.data(using: .utf8)!)
            self.surveys.removeAll()
            self.surveys.append(contentsOf: survey)
            for s in surveys{
                DispatchQueue.main.async {
                    DBManager.sharedInstance.addSurvey(object: s)
                }
            }
            tableView.reloadData()
            
        }catch{
            print(error)
        }
        
        
    }
    
    func didFailDataUpdateWithError(error: String) {
        ProgressHUD.dismiss()
        Logger.Log(from: CreateAccountVC.self, with: "Error Response \(error)")
        _ = SweetAlert().showAlert("Error!", subTitle: error,  style: AlertStyle.error, buttonTitle:"Ok", buttonColor:UIColor.red)
    }
    
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SurveyCell", for: indexPath) as? SurveyCell {
            cell.indexPath = indexPath
            cell.delegate = self
            cell.configureWithItem(survey: surveys[indexPath.item])
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension HomeVC:SurveyDelegate{
    func viewAll(indexPath: IndexPath) {
        
    }
    
    func viewDetails(indexPath: IndexPath) {
        
    }
    
    
}
