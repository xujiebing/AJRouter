//
//  UIViewController+AJRouter.swift
//  AJRouter
//
//  Created by 徐结兵 on 2019/11/18.
//

import Foundation

extension UIViewController {
    class func currentViewController() -> UIViewController? {
        var viewController:UIViewController?
        let vc = UIApplication.shared.keyWindow!.rootViewController!
        if vc is UITabBarController {
            let tabbar = vc as! UITabBarController
            viewController = tabbar.selectedViewController
        } else if vc is UINavigationController {
            let nav = vc as! UINavigationController
            viewController = nav.visibleViewController
        } else {
            viewController = vc
        }
        if viewController == nil {
            return viewController
        }
        if let presentVC = viewController!.presentedViewController {
            viewController = presentVC
        }
        return viewController;
    }
}
