//
//  AJRouterTool.swift
//  AJRouter
//
//  Created by 徐结兵 on 2019/10/29.
//

import UIKit
import SwiftyJSON

class AJRouterTool: NSObject {
    
    class func fullPathWithFillName(fileName:String) -> String? {
        let fullPath = Bundle.main.path(forResource: fileName, ofType: "json")
        return fullPath
    }
    
    class func loadJsonFileWithPath(path:String) throws -> Any? {
        let result = try String.init(contentsOfFile: path, encoding: String.Encoding.utf8)
        let data = result.data(using: String.Encoding.utf8) ?? Data()
        let obj = JSON(data).object
        return obj
    }
    
    class func routerUrlWithName(routerName:String) -> String? {
        let url = AJRouterMananger.shared.routerNameDic?[routerName]
        guard url != nil else {
            AJPrintLog("路由文件中未配置【\(routerName)】")
            return url
        }
        return url
    }
    
    class func filterUrlParams(url:String) -> String? {
        var routerUrl = url
        var targetUrl:String?
        if routerUrl.isEmpty {
            return targetUrl
        }
        let urlArray = routerUrl.components(separatedBy: "://")
        if urlArray.isEmpty {
            return targetUrl
        }
        var urlScheme:String = urlArray[0]
        var lowercaseUrlScheme = urlScheme.lowercased();
        urlScheme = urlScheme + "://"
        lowercaseUrlScheme = lowercaseUrlScheme + "://"
        routerUrl = routerUrl.replacingOccurrences(of: urlScheme, with: lowercaseUrlScheme)
        let array = routerUrl.components(separatedBy: "?")
        targetUrl = array[0]
        return targetUrl
    }
    
    class func checkParams(model:AJRouterModel) -> Bool {
        let url = model.url
        let components = URLComponents.init(string: url)
        guard components != nil else {
            return false
        }
        guard let array = components!.queryItems else {
            return false
        }
        let isValid = false
        for item:URLQueryItem in array {
            let name = item.name
            if !name.hasPrefix("*") {
                continue
            }
            let tempName = name.replacingOccurrences(of: "*", with: "")
            let value = model.params[name]
            guard value != nil else {
                AJPrintLog("【\(tempName)】为必填参数, 不能为空")
                return isValid
            }
        }
        return true
    }
    
    class func switchTabBarIndex(index:NSInteger) -> Bool {
        let currentVC = UIViewController.currentViewController()
        if let tabBar = currentVC.tabBarController {
            if index >= tabBar.childViewControllers.count {
                return false
            }
            if let nav = currentVC.navigationController {
                nav.popToRootViewController(animated: true)
            } else {
                currentVC.dismiss(animated: true, completion: nil)
            }
            currentVC.tabBarController!.selectedIndex = index
            return true
        }
        return false
    }
    
    class func viewControllerWithModel(model:AJRouterModel) -> UIViewController? {
        var vc:UIViewController?
        if model.url.isEmpty {
            AJPrintLog("路由URL为空")
            return vc
        }
        let className = model.iclass
        let iclass:AnyClass? = self.classObject(className)
        if iclass == nil {
            AJPrintLog("找不到【\(className)】需要跳转的原生类, 请检查是否有集成对应的模块")
            return vc
        }
        var params = model.params
        if params["url"] != nil {
            let targetUrl = model.url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            params["url"] = targetUrl
        }
        let vcClass = iclass as! UIViewController.Type
        vc = vcClass.init()
        let selecter = NSSelectorFromString("ajSetParameter:")
        if !params.isEmpty && vc!.responds(to: selecter) {
            vc?.performSelector(inBackground: selecter, with: params)
        }
        return vc
    }
    
    class func jumpPageWithViewController(viewController:UIViewController, jumpType:AJRouterJumpType) -> Bool {
        let vc = UIViewController.currentViewController();
        if jumpType == AJRouterJumpType.Present {
            let nav = UINavigationController.init(rootViewController: vc)
            vc.present(nav, animated: true, completion: nil)
            return true;
        } else {
            if let nav = vc.navigationController {
                nav.pushViewController(viewController, animated: true)
                return true
            }
            return false
        }
    }
    
    class func classObject(_ className:String) -> AnyClass? {
        let projectName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let classObj:AnyClass? = NSClassFromString(projectName + "." + className)
        return classObj
    }
}
