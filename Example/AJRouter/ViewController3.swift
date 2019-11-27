//
//  ViewController3.swift
//  AJRouter_Example
//
//  Created by 徐结兵 on 2019/11/23.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import AJRouter

class ViewController3: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Page3"
        self.view.backgroundColor = UIColor.white
        let button = UIButton.init(frame: CGRect.init(x: 50, y: 100, width: 200, height: 50))
        button.backgroundColor = UIColor.lightGray
            button.setTitle("Pop-1", for: UIControlState.normal)
            button.addTarget(self, action: #selector(pop), for: UIControlEvents.touchUpInside)
            self.view.addSubview(button)
        
        let button1 = UIButton.init(frame: CGRect.init(x: 50, y: 200, width: 200, height: 50))
        button1.backgroundColor = UIColor.lightGray
        button1.setTitle("Pop-2", for: UIControlState.normal)
        button1.addTarget(self, action: #selector(pop1), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button1)
        
        let button2 = UIButton.init(frame: CGRect.init(x: 50, y: 300, width: 200, height: 50))
        button2.backgroundColor = UIColor.lightGray
        button2.setTitle("Pop-3", for: UIControlState.normal)
        button2.addTarget(self, action: #selector(pop2), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button2)
        
        let button3 = UIButton.init(frame: CGRect.init(x: 50, y: 400, width: 200, height: 50))
        button3.backgroundColor = UIColor.lightGray
        button3.setTitle("Pop-4", for: UIControlState.normal)
        button3.addTarget(self, action: #selector(pop3), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button3)
    }
        
    @objc func pop() {
        AJRouterPop(index: 1)
    }
    
    @objc func pop1() {
        AJRouterPop(index: 3)
    }
    
    @objc func pop2() {
        AJRouterPop(routerUrl: "ppt://com.paopaotuan.app/module1/subPage", animated: true)
    }

    @objc func pop3() {
        AJRouterPop(routerName: "AJRouterIndexPage1", animated: true)
    }
    

}
