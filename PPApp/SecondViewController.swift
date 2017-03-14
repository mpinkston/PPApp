//
//  SecondViewController.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyUserDefaults

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogOutButtonTap(_ sender: UIButton) {
        Defaults[.authUserId] = nil
        (UIApplication.shared.delegate as! AppDelegate).dispatch()
    }
    
    @IBAction func onClearCacheButtonTap(_ sender: UIButton) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}

