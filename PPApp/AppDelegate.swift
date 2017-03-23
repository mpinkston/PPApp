//
//  AppDelegate.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyBeaver
import SwiftyUserDefaults

// Global logger
let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// Increment this version number whenever realm model changes are made
    static let realmSchemaVersion: UInt64 = 4

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let console = ConsoleDestination()  // log to Xcode Console
        log.addDestination(console)
        
        return dispatch()
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
    
    @discardableResult
    func dispatch() -> Bool {
        var rootController: UIViewController
        if let authUserId = Defaults[.authUserId] {
            initRealm(authUserId)
            rootController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        } else {
            rootController = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()!
        }
        window?.rootViewController = rootController
        
        return true
    }
    
    // Init the default Realm database
    func initRealm(_ userId: Int? = nil) {
        var config = Realm.Configuration(
            schemaVersion: AppDelegate.realmSchemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Run custom migration tasks
                }
            })
        
        // Use the default directory, but replace the filename with the userID
        if let userId = userId {
            config.fileURL = config.fileURL!
                .deletingLastPathComponent()
                .appendingPathComponent("\(userId).realm")
            log.verbose("Initted Realm DB at path: \(config.fileURL!)")
        } else {
            config.inMemoryIdentifier = "MyInMemoryRealm"
        }

        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // reset the users
        resetUsers()
    }
    
    func resetUsers() {
        let users = [
            ["name": "井本絢子", "kana": "いもと　あやこ", "image1": "imotoayako1", "image2": "imotoayako2"],
            ["name": "古坂和仁", "kana": "こさか かずひと", "image1": "kosakakazuhito1", "image2": "kosakakazuhito2"],
            ["name": "宮川大輔", "kana": "みやがわ だいすけ", "image1": "miyagawadaisuke"],
            ["name": "中岡創一", "kana": "なかおか そういち", "image1": "nakaokasoichi"],
            ["name": "手越祐也", "kana": "てごし ゆうや", "image1": "tegoshiyuya"],
            ["name": "出川哲朗", "kana": "でがわ てつろう", "image1": "degawatetsuro"],
            ["name": "内村光良", "kana": "うちむら てるよし", "image1": "uchimurateruyoshi"],
            ["name": "伊藤 麻子", "kana": "いとう あさこ", "image1": "itouasako"],
            ["name": "村上 知子", "kana": "むらかみ ともこ", "image1": "murakamitomoko"]
        ]
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(User.self))
        }
        
        for (idx, user) in users.enumerated() {
            let userObject = User(value: user)
            userObject.id = idx + 1
            try! realm.write {
                realm.add(userObject, update: true)
            }
        }
    }
}

