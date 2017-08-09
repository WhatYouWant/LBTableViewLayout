//
//  PhotosTableViewController.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/8.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit

fileprivate let kCellIdentifier = "PhotosLayoutCell"

class PhotosTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataInstance: DataManager = DataManager()
    
    private var cellHeightArray: [CGFloat] = []
    
    var modelCell: PhotosLayoutCell!
    
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64), style: .plain)
        tableView.register(PhotosLayoutCell.self, forCellReuseIdentifier: kCellIdentifier)
        self.modelCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as! PhotosLayoutCell
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
        let cell : PhotosLayoutCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as! PhotosLayoutCell
        cell.templateCell = false
        cell.model = dataInstance.modelArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        modelCell.templateCell = true
        modelCell.model = dataInstance.modelArray[indexPath.row]
        return modelCell.cellHeight
    }
    
    
    

}
