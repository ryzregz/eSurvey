//
//  QuestionnairePageVC.swift
//  I&M Survey
//
//  Created by Eclectics on 24/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit
import SwiftyJSON
class QuestionnairePageVC: UIPageViewController, UIPageViewControllerDataSource {
//    var questions = ["What is your gender", "What is your marital status?","What is your highest level of education?","What is your average monthly expenditure in Kenyan shillings (Kshs)?"]
//    var templateTypes = ["gender", "maritalstatus","profession","expense"]
    var questions = [Question]()
     var answers = [Answer]()
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait //return the value as per the required orientation
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the data source to itself
        dataSource = self
        print("No of questions \(questions.count)")
        // Create the first walkthrough screen
        if let startingViewController = questionnairViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward,
                               animated: true, completion: nil)
        }
        
        //getting data from Local Datastore if offline
        if questions.count == 0 && !Reachability.isOnline(){
            let question = DBManager.sharedInstance.getQuestions()
            questions.append(contentsOf: question)
        }
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.answeNotification(_:)), name: NSNotification.Name(rawValue: "answer"), object: nil)
        
        Logger.Log(from: QuestionnaireVC.self, with: "No of Answers \(answers.count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Register to receive notification in your class
        
    }


    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! QuestionnaireVC).index
        index -= 1
        return questionnairViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! QuestionnaireVC).index
        index += 1
        return questionnairViewController(at: index)
    }
    
    
    func questionnairViewController(at index: Int) -> QuestionnaireVC?
    {
        if index < 0 || index >= questions.count {
           return nil
        }
        // Create a new view controller and pass suitable data.
        if let pageContentViewController =
            storyboard?.instantiateViewController(withIdentifier:
                "Questionnaire") as? QuestionnaireVC {
            pageContentViewController.question = questions[index].question!
            pageContentViewController.type = questions[index].type!
            pageContentViewController.no_of_answers = answers.count
             pageContentViewController.answers = answers
            pageContentViewController.questionsSize = questions.count
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
        
    }
    
    func forward(index: Int) {
        if let nextViewController = questionnairViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated:
                true, completion: nil)
        }
    }
    
    @objc func answeNotification(_ notification: NSNotification){
        print("I have Received a notification")
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            for (key, value) in dict {
                if key as! String == "add"{
                    self.answers.append(value as! Answer)
                    Logger.Log(from: QuestionnaireVC.self, with: "Total Answers after adding \(self.answers.count)")
                    self.printAnswers()
                }else{
                    if let index =  answers.firstIndex(where: {$0 === value as! Answer}){
                        answers.remove(at: index)
                        Logger.Log(from: QuestionnaireVC.self, with: "Total Answers after removing index \(index) :\(answers.count)")
                        self.printAnswers()
                    }
                }
            }
        }
    }
    
    func printAnswers(){
        for answer in answers{
            let encodedAnserObject = try? JSONEncoder().encode(answer)
            guard let answerData = String(data: encodedAnserObject!, encoding: .utf8) else {
                return
            }
            Logger.Log(from: CreateAccountVC.self, with: "Answer \(answerData)")
        }
        
    }

}


