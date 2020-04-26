//
//  WalkthroughContentViewController.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: DefaultViewController {
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    var titleString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.currentPage = index
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        titleLabel.text = titleString
        switch index {
        case 0...1: forwardButton.setTitle("NEXT", for: .normal)
        case 2: forwardButton.setTitle("GET STARTED", for: .normal)
        default: break
        }
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        switch index {
        case 0...1:
            let pageViewController = parent as! WalkthroughPageViewController
            pageViewController.forward(index: index)
        case 2:
            ApiService.AppStore.updateValue(true, forKey: UserKeys.KEY_WELCOMED)
             UserDefaults.standard.set("yes", forKey: "welcomed")
            if let vc = storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeVC
            {
                vc.modalTransitionStyle = .flipHorizontal
                self.present(vc, animated: true)
            }
        default: break
        }
        
    }
    
    
    @IBAction func toLogin(_ sender: UIButton) {
        ApiService.AppStore.updateValue(true, forKey: UserKeys.KEY_WELCOMED)
        UserDefaults.standard.set("yes", forKey: "welcomed")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVc") as? LoginVC
        {
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc, animated: true)
        }

    }
    
}
