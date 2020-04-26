//
//  MaritalStatusTemplate.swift
//  I&M Survey
//
//  Created by Eclectics on 24/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit
import DLRadioButton

class MaritalStatusTemplate: DefaultViewController {

    @IBOutlet weak var singleRadio : DLRadioButton!
    @IBOutlet weak var marriedRadio : DLRadioButton!
    @IBOutlet weak var divorcedRadio : DLRadioButton!
    @IBOutlet weak var widowRadio : DLRadioButton!
    @IBOutlet weak var widowerRadio : DLRadioButton!
    private var radioButtonGroup = RadioGroup()
    var selected_option = ""
     var response : Answer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    
    func setupViews(){
        radioButtonGroup.addButton(singleRadio)
        radioButtonGroup.addButton(marriedRadio)
        radioButtonGroup.addButton(divorcedRadio)
        radioButtonGroup.addButton(widowRadio)
        radioButtonGroup.addButton(widowerRadio)
        
        
    }
    
    
    @IBAction func singleAction(_ sender: Any) {
         let response = Answer(type:"maritalstatus", option:"Single")
        self.radioButtonGroup.didTapButton(singleRadio, answer: response)
    }
    
    @IBAction func divorcedAction(_ sender: Any) {
         let response = Answer(type:"maritalstatus", option:"Divorced")
        self.radioButtonGroup.didTapButton(divorcedRadio, answer: response)
    }
    
    @IBAction func marriedAction(_ sender: Any) {
          let response = Answer(type:"maritalstatus", option:"Married")
        self.radioButtonGroup.didTapButton(marriedRadio, answer: response)
    }
    
    @IBAction func widowAction(_ sender: Any) {
         let response = Answer(type:"maritalstatus", option:"Widow")
        self.radioButtonGroup.didTapButton(widowRadio, answer: response)
    }
    
    @IBAction func widowerAction(_ sender: Any) {
        let response = Answer(type:"maritalstatus", option:"Widower")
        self.radioButtonGroup.didTapButton(widowerRadio, answer: response)
    }
    


}
