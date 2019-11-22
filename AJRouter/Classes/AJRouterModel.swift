//
//  AJRouterModel.swift
//  AJRouter
//
//  Created by 徐结兵 on 2019/11/11.
//

import Foundation

enum AJRouterJumpType:Int {
    case Push = 1
    case Present = 2
}

class AJRouterModel: NSObject {
    // 路由url
    var url = ""
    // url转换后的对象
    var urlComponents:URLComponents?
    // 页面名称
    var iclass = ""
    // 跳转到原生的参数
    var params = Dictionary<String,String>()
    // 跳转方式
    var jumpType = AJRouterJumpType.Push
    
    init(_ dic:[AnyHashable:String]) {
        super.init()
        if let url = dic["url"] {
            self.url = url
        }
        if let iclass = dic["iclass"] {
            self.iclass = iclass
        }
    }
    
    class func modelWithUrl(url:String, params:[String:String]?) -> AJRouterModel? {
        var model:AJRouterModel?
        if url.isEmpty {
            AJPrintLog("url为空")
            return model;
        }
        var routerUrl = url
        let urlArray = routerUrl.components(separatedBy: "://")
        if urlArray.isEmpty {
            AJPrintLog("url非法")
            return model
        }
        var urlScheme:String = urlArray[0]
        var lowercaseUrlScheme = urlScheme.lowercased();
        urlScheme = urlScheme + "://"
        lowercaseUrlScheme = lowercaseUrlScheme + "://"
        routerUrl = routerUrl.replacingOccurrences(of: urlScheme, with: lowercaseUrlScheme)
        let components = URLComponents.init(string: url)
        guard components != nil else {
            return model;
        }
        let host = components!.host
        guard host != nil else {
            AJPrintLog("【\(url)】host为空")
            return model;
        }
        let path = components!.path
        if path.isEmpty {
            AJPrintLog("【\(url)】path为空")
            return model;
        }
        let pathArray = path.components(separatedBy: "/")
        let moduleName = pathArray[1]
        if moduleName.isEmpty {
            AJPrintLog("【\(url)】模块名为空")
            return model;
        }
        let routerClassDic = AJRouterMananger.shared.routerClassDic
        guard routerClassDic != nil else {
            AJPrintLog("路由配置文件异常, 请检查路由文件")
            return model
        }
        let array = routerClassDic![moduleName]
        guard array != nil else {
            AJPrintLog("获取【\(moduleName)】下的对应路由配置信息为空")
            return model;
        }
        for item in array! {
            let itemModel = AJRouterModel.init(item)
            let itemUrl = AJRouterTool.filterUrlParams(url: itemModel.url)
            let targetUrl = AJRouterTool.filterUrlParams(url: url)
            if itemUrl == targetUrl {
                itemModel.addParameters(url: url, params: params)
                model = itemModel
                break
            }
        }
        return model;
    }
    
    private func addParameters(url:String, params:[String:String]?)  {
        let components = URLComponents.init(string: url)
        guard components != nil else {
            return
        }
        self.urlComponents = components
        guard let array = components!.queryItems else {
            return
        }
        var itemDic = [String:String]()
        for item:URLQueryItem in array {
            let name = item.name
            let value = item.value
            guard value != nil else {
                continue
            }
            if name == "jumptype" {
                if let type = Int(value!) {
                    if let jumpType = AJRouterJumpType(rawValue: type) {
                        self.jumpType = jumpType
                    }
                }
            } else {
                itemDic[name] = value!
            }
            
        }
        var dic = [String:String]()
        if params != nil {
            dic = params!
        }
        if itemDic.isEmpty {
            return
        }
        for (key, value) in itemDic {
            dic[key] = value
        }
        self.params = dic
    }
}

