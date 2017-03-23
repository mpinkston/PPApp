//
//  UserDetailView.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/23/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UserDetailView: UIView {
    
    var view: UIView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var kanaLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    var user: User? {
        didSet {
            render()
        }
    }

    func render() {
        if let image1 = user?.image1 {
            imageView1.image = UIImage(named: image1)
        }
        if let image2 = user?.image2 {
            imageView2.image = UIImage(named: image2)
            imageView2.isHidden = false
        } else {
            imageView2.isHidden = true
        }
        
        nameLabel.text = user?.name
        kanaLabel.text = user?.kana
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        view.autoPinEdgesToSuperviewEdges()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
}
