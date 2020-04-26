//
//  ExpenditureTemplate.swift
//  I&M Survey
//
//  Created by Eclectics on 24/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit
import DLRadioButton
class ExpenditureTemplate: UIViewController {
    @IBOutlet weak var belowRadio : DLRadioButton!
    @IBOutlet weak var between15Radio : DLRadioButton!
    @IBOutlet weak var between20Radio : DLRadioButton!
    @IBOutlet weak var between25Radio : DLRadioButton!
    @IBOutlet weak var above25Radio : DLRadioButton!
    private var radioButtonGroup = RadioGroup()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    
    func setupViews(){
        radioButtonGroup.addButton(belowRadio)
        radioButtonGroup.addButton(between15Radio)
        radioButtonGroup.addButton(between20Radio)
        radioButtonGroup.addButton(between25Radio)
        radioButtonGroup.addButton(above25Radio)
        
        
    }
    
    
    @IBAction func belowAction(_ sender: Any) {
         let response = Answer(type:"expense", option:"Below 10,000")
        self.radioButtonGroup.didTapButton(belowRadio, answer: response)
    }
    
    @IBAction func between15Action(_ sender: Any) {
         let response = Answer(type:"expense", option:"10,000-15,000")
        self.radioButtonGroup.didTapButton(between15Radio, answer: response)
    }
    
    @IBAction func between20Radio(_ sender: Any) {
        let response = Answer(type:"expense", option:"16,000-20,000")
        self.radioButtonGroup.didTapButton(between20Radio, answer: response)
    }
    
    @IBAction func between25Radio(_ sender: Any) {
         let response = Answer(type:"expense", option:"21,000-25,000")
        self.radioButtonGroup.didTapButton(between25Radio, answer: response)
    }
    
    @IBAction func above25Radio(_ sender: Any) {
        let response = Answer(type:"expense", option:"Above 25,000")
        self.radioButtonGroup.didTapButton(above25Radio, answer: response)
    }
    


}
