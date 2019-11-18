//
//  AJRouterManager.swift
//  AJRouter
//
//  Created by 徐结兵 on 2019/10/29.
//

import Foundation

public func AJRouterName(_ routerName:String) -> Bool {
    return AJRouterMananger.shared.routerWithName(routerName: routerName, params: nil)
}

public func AJRouterName(_ routerName:String, _ params:[String:String]) -> Bool {
    return AJRouterMananger.shared.routerWithName(routerName: routerName, params: params)
}

public class AJRouterMananger: NSObject {
    var namePath, classPath, whitePath: String?
    lazy var routerNameDic: [String:String]? = {
        var namePath:String? = self.namePath
        if namePath == nil {
            namePath = AJRouterTool.fullPathWithFillName(fileName: "routerName")
        }
        var nameDic:[String:String]?
        guard namePath != nil else {
            AJPrintLog("尚未配置【\(namePath!).json】文件")
            return nameDic;
        }
        do {
            let object = try AJRouterTool.loadJsonFileWithPath(path: namePath!)
            guard object is Dictionary<AnyHashable, String> else {
                return nameDic
            }
            nameDic = object as? [String:String]
        } catch {
            AJPrintLog("【\(namePath!).json】文件格式不正确")
        }
        return nameDic
    }()
    lazy var routerClassDic: [String:[[String:String]]]? = {
        var classPath:String? = self.classPath
        if classPath == nil {
            classPath = AJRouterTool.fullPathWithFillName(fileName: "routerClass")
        }
        var classDic:[String:[[String:String]]]?
        guard classPath != nil else {
            AJPrintLog("尚未配置【\(classPath!).json】文件")
            return classDic;
        }
        do {
            let object = try AJRouterTool.loadJsonFileWithPath(path: self.classPath!)
            guard object is Dictionary<AnyHashable, Any> else {
                return classDic;
            }
            classDic = object as? [String:[[String:String]]]
        } catch {
            AJPrintLog("【\(classPath!).json】文件格式不正确")
        }
        return classDic
    }()
    lazy var routerWhiteArray: [String]? = {
        var whitePath:String? = self.whitePath
        if whitePath == nil {
            whitePath = AJRouterTool.fullPathWithFillName(fileName: "routerWhite")
        }
        var whiteArray:[String]?
        guard whitePath != nil else {
            AJPrintLog("尚未配置【\(whitePath!).json】文件")
            return whiteArray;
        }
        do {
            let object = try AJRouterTool.loadJsonFileWithPath(path: self.whitePath!)
            guard object is Array<String> else {
                return whiteArray;
            }
            whiteArray = object as? [String]
        } catch {
            AJPrintLog("【\(whitePath!).json】文件格式不正确")
        }
        return whiteArray
    }()
    
    
    // 初始化单例方法
    public static let shared = AJRouterMananger.init()
    private override init(){
        super.init()
    }

    /// 设置路由文件路径
    /// - Parameter namePath: 路由名与路由url映射配置文件
    /// - Parameter classPath: 路由url与本地类名映射配置文件
    /// - Parameter whitePath: 白名单路由url配置文件,用于外部跳转
    public func routerFilePaths(routerNameFilePath namePath:String, routerClassFilePath classPath:String, routerWhiteFilePath whitePath: String) {
        if !namePath.isEmpty {
            self.namePath = namePath
        }
        if !classPath.isEmpty {
            self.classPath = classPath
        }
        if !whitePath.isEmpty {
            self.whitePath = whitePath
        }
    }
    
    /// 更新路由文件路径
    /// - Parameter namePath: 路由名与路由url映射配置文件
    /// - Parameter classPath: 路由url与本地类名映射配置文件
    /// - Parameter whitePath: 白名单路由url配置文件,用于外部跳转
    public func reloadRouterFilePaths(routerNameFilePath namePath: String, routerClassFilePath classPath:String, routerWhiteFilePath whitePath: String) {
        if !namePath.isEmpty {
            self.routerNameDic = nil
            self.namePath = namePath
        }
        if !classPath.isEmpty {
            self.routerClassDic = nil
            self.classPath = classPath
        }
        if !whitePath.isEmpty {
            self.routerWhiteArray = nil
            self.whitePath = whitePath
        }
    }
    
    /// 根据路由名进行跳转
    /// - Parameter name: 路由名
    /// - Parameter params: 参数
    public func routerWithName(routerName name:String, params:[String:String]?) -> Bool {
        let routerUrl = AJRouterTool.routerUrlWithName(routerName: name)
        guard routerUrl != nil else {
            return false;
        }
        return self.routerWithUrl(routerUrl: routerUrl!, params: params)
    }
    
    /// 根据路由url进行跳转
    /// - Parameter url: 路由url
    /// - Parameter params: 参数
    public func routerWithUrl(routerUrl url:String, params:[String:String]?) -> Bool {
        if url.hasPrefix("http://") || url.hasPrefix("https://") {
            return AJRouterTool.openUrlInSafari(urlString: url)
        }
        let model = AJRouterModel.modelWithUrl(url: url, params: params)
        if model == nil {
            AJPrintLog("路由异常，请检查路由")
            return false
        }
        guard AJRouterTool.checkParams(model: model!) else {
            AJPrintLog("参数校验不合法")
            return false
        }
        return self.router(routerModel: model!);
    }
    
    /// 返回上级页面
    public func popRouter() {
        
    }
    
    /// 返回N级页面
    public func popRouter(index:Int) {
        
    }
    
    /// 返回指定路由页面
    /// - Parameter url: 指定路由
    /// - Parameter animated: 是否有转场动画
    public func popRouter(routerUrl url:String, animated:Bool)  {
        
    }
    
    public func viewControllerWithUrl(routerUrl url:String) -> String {
        return "";
    }
    
    func router(routerModel:AJRouterModel) -> Bool {
        if routerModel.urlComponents!.path == "/tab" {
            if let indexNum = routerModel.params["index"] {
                var complete = false
                if let index = Int(indexNum) {
                    complete = AJRouterTool.switchTabbarIndex(index: index)
                }
                return complete
            }
            return false
        }
        return true
    }
}


//        // 页面跳转
//        UIViewController *vc = weakSelf.pageWithModel(model);
//        if (!vc) {
//            DBRouterLog(@"当前vc为空, 是否未集成当前vc所在的模块?")
//            DBRouterPopTool.alert(@"无法获取到目标页面");
//            return complete;
//        }
//        complete = weakSelf.jumpPageWithViewController(model.jumpType, vc);
//        return complete;
//    };
//    return block;
//}
