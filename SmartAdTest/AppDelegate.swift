//
//  AppDelegate.swift
//  SmartAdTest
//
//  Created by Ignacio Barrea on 2/1/17.
//  Copyright © 2017 Ignacio Barrea. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SASAdViewDelegate {

    var window: UIWindow?
    fileprivate var startupInterstitial: SASInterstitialView! // Instance of the interstitial (marked as optional since it is created after the initialization of the controller)
    fileprivate var statusBarHidden = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // The site ID and the base URL must be set before using the SDK, otherwise no ad will be retrieved.
        SASAdView.setSiteID(Constants.siteID(), baseURL: Constants.baseURL())
        
        // Enabling logging can be useful to get informations if ads are not displayed properly.
        // Don't forget to turn logging OFF before submitting to the App Store.
        SASAdView.setLoggingEnabled(true)
        
        // You can enable the test mode if you want the SDK to retrieve sample ads that always deliver instead
        // of your own ads. You will only receive a simple image banner or an interstitial depending on the type of
        // SASAdView you are using.
        // Don't forget to turn test mode OFF before submutting to the App Store.
        SASAdView.setTestModeEnabled(false)
        
        
        //Load Interstitital
        if !(startupInterstitial != nil) {
            // We create the interstitial with a black activity indicator as the loader and fullscreen ie. with no status bar.

            startupInterstitial = SASInterstitialView(frame: self.window!.frame, loader:SASLoader.activityIndicatorStyleBlack)
            
        }
        // Set self as the delegate, so that it will notify this instance of changes in its life cycle
        self.startupInterstitial.delegate = self
        
        let controller = ViewController()
        // The modalParentViewController must be a view controller since it will be used to display the post click modal view
        self.startupInterstitial.modalParentViewController = controller
        // Set the dismissalAnimations property to the animations block containing everything you want to animate
        // Use the adView block parameter not to have to worry about reference circles
        
        self.startupInterstitial.dismissalAnimations = {(_ adView: SASAdView) -> Void in
            adView.alpha = 0
        }
        // Load the ad for the given tags
        startupInterstitial.loadFormatId(Constants.interstitialFormatID(), pageId: Constants.interstitialPageID(), master: true, target: "videointerstitial14", timeout: 10)
        
        // Add the view to the rootViewController so that it stays fullscreen
        self.window?.rootViewController!.view.addSubview(startupInterstitial)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
   


}

