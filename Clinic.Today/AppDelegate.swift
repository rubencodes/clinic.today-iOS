//
//  AppDelegate.swift
//  Clinic.Today
//
//  Created by Ruben on 8/7/14.
//  Copyright (c) 2014 Ruben. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    var window:  UIWindow?
    var patient: Patient?
    var clinic:  Clinic?
    var locationManager: CLLocationManager?
    var coordinate: CLLocationCoordinate2D?
    var primaryColor   = UIColor(red: 110/255, green: 162/255, blue: 173/255, alpha: 1)
    var secondaryColor = UIColor(red: 28/255,  green: 63/255,  blue: 133/255, alpha: 1)

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        UINavigationBar.appearance().translucent  = false
        UINavigationBar.appearance().tintColor    = self.secondaryColor
        UINavigationBar.appearance().barTintColor = self.primaryColor
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : UIFont(name: "OpenSans-Semibold", size: 28), NSForegroundColorAttributeName : UIColor.whiteColor()]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont(name: "OpenSans-Light", size: 18)], forState: UIControlState.Normal)
        UINavigationBar.appearance().setTitleVerticalPositionAdjustment(2, forBarMetrics: UIBarMetrics.Default)
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        self.locationManager!.distanceFilter  = kCLDistanceFilterNone
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager!.startUpdatingLocation()
        self.locationManager!.requestWhenInUseAuthorization()

        return true
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        self.coordinate = manager.location.coordinate
        manager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("ERROR \(error.localizedDescription)")
    }

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

}

