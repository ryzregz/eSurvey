//
//  WalkthroughPageViewController.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Morris. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    var pageImages = ["corousel_img", "onboarding_one", "onboarding_two"]
    var pageTitles = ["LOREM IPSUM DOLAR", "LOREM IPSUM DOLAR", "LOREM IPSUM DOLAR"]
    var pageContent = ["Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed ","Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed ","Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed "]
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait //return the value as per the required orientation
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.addSublayer(GlobalVariables.OnbaordingGradient)
        
        // Set the data source to itself
        dataSource = self
        
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward,
                               animated: true, completion: nil)
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController?
    {
        if index < 0 || index >= pageImages.count {
            return nil
        }
        // Create a new view controller and pass suitable data.
        if let pageContentViewController =
            storyboard?.instantiateViewController(withIdentifier:
                "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.titleString = pageTitles[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            return pageContentViewController
        }
        return nil
        
    }
    
    func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated:
                true, completion: nil)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
