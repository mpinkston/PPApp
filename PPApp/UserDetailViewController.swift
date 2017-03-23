//
//  UserDetailViewController.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/23/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import UIKit
import SwiftyTimer

protocol UserDetailDelegate: class {
    func userDetailCancel()
    func userDetail(didAction1 action: String)
}

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    var delegate: UserDetailDelegate?
    var user: User? = nil
    
    var timer: Timer? = nil
    
    override func viewDidLoad() {
        timer = Timer.every(2.seconds) { [unowned self] (timer: Timer) in
            let description = "<\(type(of: self)): 0x\(String(unsafeBitCast(self, to: Int.self), radix: 16, uppercase: false))>"
            log.info(description)
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailsLabel.text = "Details for \(user?.name ?? "Anonymous??")"
    }
    
    @IBAction func onAction1Tap(_ sender: UIButton) {
        delegate?.userDetail(didAction1: "Performed action 1!!")
    }
    
    @IBAction func onCancelTap(_ sender: UIButton) {
        delegate?.userDetailCancel()
    }
    
}
