//
//  UsersTableViewController.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/17/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import RxSwift
import RxCocoa
import RxRealm

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var detailView: UserDetailView!
    @IBOutlet weak var detailViewHeight: NSLayoutConstraint!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        // dataSource, delegateはストーリーボードで定義してある
        // tableView.dataSource = self
        // tableView.delegate = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        
        // Detail view concerns
        detailViewHeight.constant = 0
        detailView.detailButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            guard let user = self.detailView.user else { return }

            let controller = self.storyboard?.instantiateViewController(withIdentifier: "userDetailViewController") as! UserDetailViewController
            controller.user = user
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)
            
        }).addDisposableTo(disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func getUsers() -> Results<User> {
        let realm = try! Realm()
        return realm.objects(User.self)
    }
    
    func showDetailView() {
        guard detailViewHeight.constant != 200 else { return }
        detailViewHeight.constant = 200
        UIView.animate(withDuration: 0.5) { 
            self.view.layoutIfNeeded()
        }
    }
}

extension UsersViewController: UserDetailDelegate {
    func userDetailCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func userDetail(didAction1 action: String) {
        log.info("An action occurred! \(action)")
        dismiss(animated: true, completion: nil)
    }
}

extension UsersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getUsers().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        cell.user = getUsers()[indexPath.row]
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailView()
        detailView.user = getUsers()[indexPath.row]
    }
}
