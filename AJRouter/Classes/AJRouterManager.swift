//
//  AJRouterManager.swift
//  AJRouter
//
//  Created by 徐结兵 on 2019/10/29.
//

import Foundation

public class AJRouterMananger: NSObject {
    
    var namePath, classPath, whitePath: String
    
    // 初始化单例方法
    public static let shared = AJRouterMananger.init()
    private override init(){
        self.namePath = "routerName.json"
        self.classPath = "routerClass.json"
        self.whitePath = "routerWhite.json"
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
        
    }
    
    /// 根据路由名进行跳转
    /// - Parameter name: 路由名
    public func routerWithName(routerName name:String) -> Bool {
        return true;
    }
    
    /// 根据路由名进行跳转
    /// - Parameter name: 路由名
    /// - Parameter params: 参数
    public func routerWithName(routerName name:String, params:[String:String]) -> Bool {
        return true;
    }
    
    /// 根据路由url进行跳转
    /// - Parameter url: 路由url
    public func routerWithUrl(routerUrl url:String) -> Bool {
        return true;
    }
    
    /// 根据路由url进行跳转
    /// - Parameter url: 路由url
    /// - Parameter params: 参数
    public func routerWithUrl(routerUrl url:String, params:[String:String]) -> Bool {
        return true;
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
}


