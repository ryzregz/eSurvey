//
//  GenderVC.swift
//  I&M Survey
//
//  Created by Eclectics on 24/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit
import DLRadioButton
class GenderTemplate: DefaultViewController {
    @IBOutlet weak var maleRadio : DLRadioButton!
    @IBOutlet weak var femaleRadio : DLRadioButton!
    private var radioButtonGroup = RadioGroup()
    var response : Answer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        self.radioButtonGroup.addButton(maleRadio)
        self.radioButtonGroup.addButton(femaleRadio)
        
    }
    
    @IBAction func femaleAction(_ sender: Any) {
        let res = Answer(type: "gender", option: "Male")
        self.radioButtonGroup.didTapButton(femaleRadio, answer: res)
    }
    
    @IBAction func maleAction(_ sender: Any) {
        let res = Answer(type:"gender", option:"Female")
        self.radioButtonGroup.didTapButton(maleRadio, answer: res)
    }
    
  

}


