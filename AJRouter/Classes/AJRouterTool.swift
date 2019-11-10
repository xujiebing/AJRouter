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
}
