//
//  ImageAutoLayoutController.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/2.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit

fileprivate let kCellIdentifier = "Cell"

class ImageAutoLayoutController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private let dataManager : DataManager = DataManager()
    
    private var cellHeightArray: [CGFloat] = []
    
    lazy var tableView: UITableView = { [unowned self] in
       let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), style: .plain)
        tableView.register(LayoutCell.self, forCellReuseIdentifier: kCellIdentifier)
        self.modelCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as! LayoutCell
        self.modelCell.templateCell = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    private var modelCell : LayoutCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("---start cellForRowAt---")
        let cell : LayoutCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as! LayoutCell
        cell.templateCell = false
        cell.model = dataManager.modelArray[indexPath.row]
        print("---after cellForRowAt---")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("---start heightForRowAt---")
        
        if indexPath.row < cellHeightArray.count {
            return cellHeightArray[indexPath.row]
        }
        
        modelCell.model = dataManager.modelArray[indexPath.row]
        cellHeightArray.append(modelCell.cellHeight)
        
        print("---after heightForRowAt:\(modelCell.cellHeight)---")
        return modelCell.cellHeight
    }
    

}

