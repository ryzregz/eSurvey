//
//  RadioGroup.swift
//  I&M Survey
//
//  Created by Eclectics on 23/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton




class RadioGroup {
    private var buttons: [DLRadioButton] = []
    var answers = [Answer]()
    
    var selectedButton: DLRadioButton? { return buttons.filter { $0.isSelected }.first  }
    
    func addButton(_ button: DLRadioButton) {
        Logger.Log(from: RadioGroup.self, with: "Button with Tag \(button.tag) added")
        buttons.append(button)
    }
    
    func didTapButton(_ button: DLRadioButton, answer: Answer) {
        Logger.Log(from: RadioGroup.self, with: "Button with Tag \(button.tag) clicked")
         button.isSelected = true
         deselectButtonsOtherThan(button,answer)
        let dict : [String:Answer] = ["add": answer]
        // post an anser  notification
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "answer"), object: nil, userInfo: dict)
    }
    
    private func deselectButtonsOtherThan(_ selectedButton: DLRadioButton, _ answer: Answer) {
        Logger.Log(from: RadioGroup.self, with: "Button with Tag \(selectedButton.tag) selected")
        for button in buttons where button != selectedButton {
            button.isSelected = false
             let dict : [String:Answer] = ["remove": answer]
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: dict)
        }
       
    }
}
