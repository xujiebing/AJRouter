//
//  ViewController1.swift
//  AJRouter_Example
//
//  Created by 徐结兵 on 2019/11/23.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import AJRouter

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Page1"
        self.view.backgroundColor = UIColor.white
        let button = UIButton.init(frame: CGRect.init(x: 50, y: 100, width: 200, height: 50))
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Push", for: UIControlState.normal)
        button.addTarget(self, action: #selector(push), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func push() {
        AJRouterName(routerName: "AJRouterIndexPage3", params: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
