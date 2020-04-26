//
//  WelcomeVC.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit
import SwiftyJSON
protocol PassQuestionsDelegate : class{
    func passData(questions: [Question])
}
class WelcomeVC: DefaultViewController {
    var passdatadelegate : PassQuestionsDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    @IBAction func toLoginAction(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        {
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc, animated: true)
        }
    }
    @IBAction func toSignUpAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CreateAccountVC") as? CreateAccountVC
        {
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc, animated: true)
        }
    }


}


