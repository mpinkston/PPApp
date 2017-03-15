//
//  LayoutTestViewController.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/15/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SwiftyTimer
import RxSwift
import RxCocoa

class LayoutTestViewController: UIViewController {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view1LeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var view1TopConstraint: NSLayoutConstraint!
    
    var viewContainer: UIView?
    var view2: UIView?
    var view3: UIView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initReloadButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initReloadButton() {
        let buttonWidth = CGFloat(150)
        let buttonFrame = CGRect(
            x: view.frame.width / 2 - buttonWidth / 2,
            y: view.frame.height - 200,
            width: buttonWidth,
            height: 38.0)
        
        let button = UIButton(frame: buttonFrame)
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 2.0
        view.addSubview(button)
        
        _ = button.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.onReloadButtonTap()
        })
    }
    
    func onReloadButtonTap() {
        view1LeadingConstraint.constant = 28
        view1TopConstraint.constant = 81
        view.layoutIfNeeded()
        
        viewContainer?.removeFromSuperview()
        viewContainer = UIView(frame: .zero)
        
        view2?.removeFromSuperview()
        view2 = UIView(frame: .zero)
        
        view3?.removeFromSuperview()
        view3 = UIView(frame: .zero)
        
        guard let viewContainer = viewContainer, let view2 = view2, let view3 = view3 else { return }

        view.addSubview(viewContainer)
        view.bringSubview(toFront: viewContainer)
        viewContainer.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 200, height: 200))
            make.left.equalTo(view1.snp.centerX)
            make.top.equalTo(view1.snp.centerY)
        }
        
        view2.alpha = 0
        viewContainer.addSubview(view2)
        view2.backgroundColor = UIColor.green
        view2.snp.makeConstraints { (make) in
            make.edges.equalTo(viewContainer)
        }
        
        viewContainer.addSubview(view3)
        view3.isHidden = true
        view3.layer.borderColor = UIColor.blue.cgColor
        view3.layer.borderWidth = 1.0
        let ppap = UIImageView(image: UIImage(named: "ppap"))
        ppap.contentMode = .scaleAspectFill
        ppap.clipsToBounds = true
        view3.addSubview(ppap)
        ppap.snp.makeConstraints { (make) in
            make.edges.equalTo(view3)
        }
        
        view3.snp.makeConstraints({ (make) in
            make.edges.equalTo(viewContainer)
        })
        
        UIView.animate(withDuration: 0.4, animations: {
            view2.alpha = 1
        }, completion: { complete in
            Timer.after(1.second, {
                self.view1LeadingConstraint.constant = 58
                self.view1TopConstraint.constant = 140
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { complete in
                    UIView.transition(
                        from: view2,
                        to: view3,
                        duration: 0.4,
                        options: [
                            .transitionFlipFromRight,
                            .showHideTransitionViews
                        ],
                        completion: nil)
                })
            })
        })
        
    }
}
