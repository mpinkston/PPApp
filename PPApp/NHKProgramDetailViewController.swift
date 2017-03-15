//
//  NHKProgramDetailViewController.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/9/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import UIKit

class NHKProgramDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // @IBOutlet weak var programImage: UIImageView!
    
    @IBOutlet weak var programImage: UIImageView!
    
    var programDescription: NHKDescription? {
        didSet {
            guard isViewLoaded else { return }
            render()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        render()
    }
    
    func render() {
        guard programDescription?.isInvalidated == false else { return }
        
        titleLabel.text = programDescription?.title
        subtitleLabel.text = programDescription?.subtitle
        
        if let logoUrl = programDescription?.programLogo, var components = URLComponents(string: logoUrl) {
            components.scheme = "http"
            programImage.sd_setImage(with: components.url)
        }
    }
}
