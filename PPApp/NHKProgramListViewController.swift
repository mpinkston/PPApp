//
//  NHKProgramListViewController.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/9/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import SDWebImage
import SwiftDate
import PureLayout

class NHKProgramListViewController: UITableViewController {
    
    fileprivate var disposeBag = DisposeBag()
    fileprivate var programs: [NHKProgram] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitViewController?.preferredDisplayMode = .allVisible
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.title = "NHK Program List"
        loadPrograms()
    }
    
    func loadPrograms() {
        let request = NHKProgramListRequest()
        request.area = "130" // 東京
        request.service = "g1" // ＮＨＫ総合１
        request.date = Date().string(custom: "yyyy-MM-dd")
        
        API.NHK.programList(request: request).subscribe(onNext: { [weak self] (programs) in
            guard let me = self else { return }
            me.programs.removeAll()
            me.programs = programs
            me.tableView.reloadData()
            }, onError: { (error) in
                log.error(error)
        }).addDisposableTo(disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "programCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "programCell")
        }
        
        let program = programs[indexPath.row]        
        cell!.textLabel?.text = program.title
        if let programStartTime = program.startTime {
            cell!.detailTextLabel?.text = programStartTime.string(dateStyle: .short, timeStyle: .medium)
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let request = NHKProgramInfoRequest(program: programs[indexPath.row]) else { return }
        
        API.NHK.programInfo(request: request).subscribe(onNext: { [weak self] description in
            guard let me = self else { return }
            me.performSegue(withIdentifier: "showProgramDetailSegue", sender: description)
        }, onError: { (error) in
            log.info("noi")
        }).addDisposableTo(disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProgramDetailSegue" {
            let controller = (segue.destination as! UINavigationController).topViewController as! NHKProgramDetailViewController
            controller.programDescription = sender as? NHKDescription
        }
    }
}

extension NHKProgramListViewController: UISplitViewControllerDelegate {
//    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
//        return collapseDetailViewController
//    }
}
