//
//  Cells.swift
//  I&M Survey
//
//  Created by Eclectics on 26/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import Foundation
import UIKit
protocol SurveyDelegate: class {
    func viewAll(indexPath: IndexPath)
     func viewDetails(indexPath: IndexPath)
}
class SurveyCell: UITableViewCell{
        @IBOutlet weak var Title: UILabel!
        @IBOutlet weak var TotalAnsers: UILabel!
        @IBOutlet weak var CreatedAt: UILabel!
        @IBOutlet weak var Description: UILabel!
        @IBOutlet weak var Status: UILabel!
        @IBOutlet weak var viewDetailsBtn: UIButton!
        @IBOutlet weak var viewAllBtn: UIButton!
    
    public var indexPath:IndexPath!
    weak var delegate:SurveyDelegate?
    
    func configureWithItem(survey: Survey) {
        // add gradient
        Title.text = survey.name
        Description.text = survey.desc
        CreatedAt.text = survey.created_at
        TotalAnsers.text = survey.total_answers
         Status.text = "COMPLETED"
//        if(survey.status == "1"){
//            Status.text = "COMPLETED"
//        }else{
//            Status.text = "ACTIVE"
//        }
        
    }
    
    @IBAction func viewAllAction(_ sender: UIButton) {
            delegate?.viewAll(indexPath: indexPath)
    }
    
    
    @IBAction func viewDetailsAction(_ sender: UIButton) {
        delegate?.viewDetails(indexPath: indexPath)
    }
}
