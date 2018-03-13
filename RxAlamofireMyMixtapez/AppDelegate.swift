//
//  AppDelegate.swift
//  RxAlamofireMyMixtapez
//
//  Created by HugoSilva on 2/7/18.
//  Copyright © 2018 HugoSilva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        Request.Token.TokenType = "bearer"
//
//        Request.Token.AccessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1MjA0NTUwMTYsInVzZXJfbmFtZSI6IjI5NDI0MjAiLCJhdXRob3JpdGllcyI6WyJST0xFX1VTRVIiXSwianRpIjoiNjI5YzE3YTctNWI2ZS00MmJkLThlMWUtOTM4MWE2NWRhYTYyIiwiY2xpZW50X2lkIjoiYW5kcm9pZCIsInNjb3BlIjpbInJlYWQiXX0.fbelypC3tMEeCMiO9Dc6S0XJ1lO8fdGuHTSj_8A3Uiosdf"
//
//        Request.Token.RefreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX25hbWUiOiIwIiwic2NvcGUiOlsicmVhZCJdLCJhdGkiOiJlZWUwZmVjOC04NmNkLTRhYmMtODIyYS00NTgzMmI1OWQ1YjciLCJleHAiOjE1MjU2Mjk2NDMsImF1dGhvcml0aWVzIjpbIlJPTEVfR1VFU1QiXSwianRpIjoiZDQ3NGIwNWItNmIyNi00MGY1LTk1NzEtYzQzNjViMDBmYzA3IiwiY2xpZW50X2lkIjoiaW9zIn0.QpcIC49TrgiS00nH0o87WI5Lyr0CYN1NGOFuauxuO0E"

        
        
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

