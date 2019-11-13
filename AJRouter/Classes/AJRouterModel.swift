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
    var jupType = AJRouterJumpType.Push
    
    class func modelWithUrl(url:String) -> AJRouterModel? {
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
            AJPrintLog("路由配置文件为空, 请检查路由")
            return model
        }
        let array = routerClassDic![moduleName]
        guard array != nil else {
            AJPrintLog("获取【\(moduleName)】下的对应路由配置信息为空")
            return model;
        }
        for item in array! {
            
        }
//        [array enumerateObjectsUsingBlock:^(NSDictionary *item, NSUInteger idx, BOOL * _Nonnull stop) {
//            DBRouterModel *tempModel = DBRouterModel.dbObjectWithKeyValues(item);
//            // 过滤请求参数
//            NSString *modelURL = DBRouterTool.filterUrlParams(tempModel.url);
//            NSString *targetUrl = DBRouterTool.filterUrlParams(url);
//            if([modelURL isEqualToString:targetUrl]) {
//                tempModel.addParameters(url, params);
//                model = tempModel;
//                *stop = YES;
//            }
//        }];
        return model;
    }
    
    func addParameters(url:String, params:[AnyHashable:Any])  {
        
    }
    

}

