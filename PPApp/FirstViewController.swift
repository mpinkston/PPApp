//
//  FirstViewController.swift
//  PPApp
//
//  Created by Matthew Pinkston on 3/8/17.
//  Copyright © 2017 Matthew Pinkston. All rights reserved.
//

import UIKit
import SwiftDate
import RxSwift

class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var programs: [NHKProgram] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPrograms()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        programs.removeAll()
    }
    
    func loadPrograms() {
        let request = NHKProgramListRequest()
        request.area = "130" // 東京
        request.service = "g1" // ＮＨＫ総合１
        request.date = Date().string(custom: "yyyy-MM-dd")
        
        API.NHK.programList(request: request).subscribe(onNext: { [weak self] (progs) in
            guard let me = self else { return }
            me.programs.removeAll()
            me.programs = progs
            me.tableView.reloadData()
            }, onError: { (error) in
                log.error(error)
        }).addDisposableTo(disposeBag)
    }
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "programCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "programCell")
        }
        cell!.textLabel?.text = programs[indexPath.row].title
        return cell!
    }
}
