//
//  ViewController.swift
//  AJRouter
//
//  Created by xujiebing on 10/28/2019.
//  Copyright (c) 2019 xujiebing. All rights reserved.
//

import UIKit
import AJRouter

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func push(_ sender: Any) {
//        AJRouterName("AJRouterIndexPage2", nil)
        AJRouterPop(index: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

