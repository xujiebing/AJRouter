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
        return JSON(data).object
    }
    
    class func routerUrlWithName(routerName:String) -> String? {
        let url = AJRouterMananger.shared.routerNameDic?[routerName]
        guard url != nil else {
            AJPrintLog("路由文件中未配置【\(routerName)】")
            return url
        }
        return url
    }
    
    class func openUrlInSafari(urlString:String) -> Bool {
        let url = URL.init(string: urlString)
        if url != nil {
            return false;
        }
        guard !UIApplication.shared.canOpenURL(url!) else {
            AJPrintLog("打开系统自带浏览器时, URL格式传的不对, URL是:\(urlString)")
            return false;
        }
        return UIApplication.shared.openURL(url!);
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
    
    class func switchTabbarIndex(index:NSInteger) -> Bool {
        if let currentVC = UIViewController.currentViewController() {
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
        return false
    }
}
