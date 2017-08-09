//
//  ViewController.swift
//  LBTableViewLayout
//
//  Created by ZhanyaaLi on 2017/8/2.
//  Copyright © 2017年 Hangzhou Zhanya Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func demo01Action(_ sender: UIButton) {
        pushController(to: ImageAutoLayoutController())
    }
    
    @IBAction func demoXibAction(_ sender: UIButton) {
        pushController(to: ImageAutoLayoutXibController())
    }
    
    @IBAction func demoOCAction(_ sender: UIButton) {
        pushController(to: OCXibAutoLayoutController())
    }
    
    @IBAction func demoImages(_ sender: UIButton) {
        pushController(to: PureImagesAutoLayoutController())
    }
    
    @IBAction func photoTable(_ sender: UIButton) {
        pushController(to: PhotosTableViewController())
    }
    
    @IBAction func timelineAction(_ sender: UIButton) {
        pushController(to: TimelineController())
    }
    
    func pushController(to controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }

}

