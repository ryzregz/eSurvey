//
//  AppDelegate.swift
//  I&M Survey
//
//  Created by Eclectics on 21/04/2020.
//  Copyright © 2020 Eclectics. All rights reserved.
//

import UIKit
import PluggableApplicationDelegate
import RealmSwift
@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
    var visualEffectView = UIVisualEffectView()
    fileprivate static var config:Config?
    //
    static var AppConfig:Config?{
        get{
            return config
        }
        set{
            config = newValue
        }
    }
    
    override var services: [AppServices] {
        return [
            DefaultAppService()
        ]
    }
    //
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       // UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor(red: 65/255, green: 27/255, blue: 141/255, alpha: 1.0)
        if let barFont = UIFont(name: "AvenirNextCondensed-DemiBold", size: 24.0){
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font:barFont]
        }

        
        //Default App Global Config
        do {
            //
            if let url = Bundle.main.url(forResource: "config", withExtension: "plist") {
                //
                let data = try Data(contentsOf: url)
                //
                AppDelegate.config = try PropertyListDecoder().decode(Config.self, from: data)
            }
        }catch{
            print(error)
            Logger.Log(from:self,with:"Config Error :: \(error)")
        }
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        let _ = try! Realm()
 
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        super.applicationWillResignActive(application)
        //
        if !self.visualEffectView.isDescendant(of: self.window!) {
            let blurEffect = UIBlurEffect(style: .light)
            self.visualEffectView = UIVisualEffectView(effect: blurEffect)
            self.visualEffectView.alpha = 0.95
            self.visualEffectView.frame = (self.window?.bounds)!
            self.window?.addSubview(self.visualEffectView)
        }
        //
        Logger.Log(from:self,with:"applicationWillResignActive")
    }
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Logger.Log(from:self,with:"applicationDidEnterBackground")
        super.applicationDidEnterBackground(application)
    }
    
    override func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        Logger.Log(from:self,with:"applicationWillEnterForeground")
        super.applicationWillEnterForeground(application)
        self.visualEffectView.removeFromSuperview()
        //
        attemptLogout()
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        super.applicationDidBecomeActive(application)
        //
        self.visualEffectView.removeFromSuperview()
        Logger.Log(from:self,with:"applicationDidBecomeActive")
        attemptLogout()
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        super.applicationWillTerminate(application)
    }
    
    //
    @objc func attemptLogout(){
        //
        if getVisibleViewController(window!.rootViewController) is LoginVC{
            //
            Logger.Log(from:self,with:"AppDelegate :: Already Logged Out")
        }else{
            Logger.Log(from:self,with:"AppDelegate :: Logout User")
            //
            //NavigationDrawer.sharedInstance.
            if let y = ApiService.AppStore[UserKeys.KEY_SIGNUP_COMPLETE] as? Bool, //let _ = DbContext().getUser(),
                y {
                //
                window!.rootViewController?.dismiss(animated: true, completion: {
                    //
                    let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    //
                    let vc = mainStoryboardIpad.instantiateViewController(withIdentifier: "Services") as UIViewController
                    //
                    self.window?.rootViewController = vc
                    //
                    self.window?.makeKeyAndVisible()
                })
            }
        }
        //
        
    }
    
    func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        
        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if rootVC?.presentedViewController == nil {
            return rootVC
        }
        
        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }
            
            return getVisibleViewController(presented)
        }
        return nil
    }
}

