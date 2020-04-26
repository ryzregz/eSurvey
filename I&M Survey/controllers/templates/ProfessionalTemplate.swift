//
//  ProfessionalTemplate.swift
//  I&M Survey
//
//  Created by Eclectics on 24/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit
import DLRadioButton
class ProfessionalTemplate: UIViewController {
    @IBOutlet weak var primaryRadio : DLRadioButton!
    @IBOutlet weak var bacherorRadio : DLRadioButton!
    @IBOutlet weak var mastersRadio : DLRadioButton!
    @IBOutlet weak var doctorateRadio : DLRadioButton!
    @IBOutlet weak var otherRadio : DLRadioButton!
    @IBOutlet weak var otherProfessionTextField : UITextField!
    private var radioButtonGroup = RadioGroup()
    var selected_option = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    
    func setupViews(){
        radioButtonGroup.addButton(primaryRadio)
        radioButtonGroup.addButton(bacherorRadio)
        radioButtonGroup.addButton(mastersRadio)
        radioButtonGroup.addButton(doctorateRadio)
        radioButtonGroup.addButton(otherRadio)
    }
    
    @IBAction func primaryAction(_ sender: Any) {
        let response = Answer(type:"profession", option:"Primary/Secondary")
        self.radioButtonGroup.didTapButton(primaryRadio, answer: response)
    }
    
    @IBAction func bacherorAction(_ sender: Any) {
        let response = Answer(type:"profession", option:"Bachelor Degree")
        self.radioButtonGroup.didTapButton(bacherorRadio, answer: response)
    }
    
    @IBAction func mastersAction(_ sender: Any) {
        let response = Answer(type:"profession", option:"Master Degree")
        self.radioButtonGroup.didTapButton(mastersRadio, answer: response)
    }
    
    @IBAction func doctorateAction(_ sender: Any) {
        let response = Answer(type:"profession", option:"Doctor of Philosophy")
        self.radioButtonGroup.didTapButton(doctorateRadio, answer: response)
    }
    
    @IBAction func otherAction(_ sender: Any) {
        if let option =  otherProfessionTextField.text{
              let response = Answer(type:"profession", option:option)
             self.radioButtonGroup.didTapButton(otherRadio, answer: response)
        }
        
    }
    



}
