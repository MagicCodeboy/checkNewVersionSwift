//
//  ViewController.swift
//  CheckNewVersionSwift
//
//  Created by lalala on 2017/4/20.
//  Copyright © 2017年 lsh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.checkNewVersion()
    }
    func checkNewVersion() {
        CheckNewVersion.checkNewWithVersion(appId: "963994756", controller: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

