//
//  AuthController.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/9/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class AuthController: UIViewController {
    
    @IBAction func onLogInButtonTap(_ sender: UIButton) {
        // Log in code goes here
        Defaults[.authUserId] = 1
        
        (UIApplication.shared.delegate as? AppDelegate)?.dispatch()
    }
}
