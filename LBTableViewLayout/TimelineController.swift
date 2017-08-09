//
//  TimelineController.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/8.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit

fileprivate let kCellIdentifier = "TimelineCell"

class TimelineController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataInstance: DataManager = DataManager()
    
    private var cellHeightArray: [CGFloat] = []
    
    var modelCell: TimelineCell!
    
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64), style: .plain)
        tableView.register(TimelineCell.self, forCellReuseIdentifier: kCellIdentifier)
        self.modelCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as! TimelineCell
        self.modelCell.templateCell = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .red
        //        tableView.estimatedRowHeight = 100
        //        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableViewDelegate && UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataInstance.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TimelineCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as! TimelineCell
        cell.model = dataInstance.modelArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        modelCell.model = dataInstance.modelArray[indexPath.row]
        return modelCell.cellHeight
//        return kScreenWidth+200
    }
    
    
    

}
