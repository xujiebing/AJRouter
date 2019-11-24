//
//  AJRouter.swift
//  AJRouter
//
//  Created by 徐结兵 on 2019/11/23.
//

import Foundation
import SwiftyJSON

/// 设置路由文件路径
/// - Parameters:
///   - namePath: 路由名与路由url映射配置文件
///   - classPath: 路由url与本地类名映射配置文件
///   - whitePath: 白名单路由url配置文件,用于外部跳转
public func AJRouterFilePaths(namePath:String, classPath:String, whitePath: String) {
    AJRouterMananger.shared.routerFilePaths(routerNameFilePath: namePath, routerClassFilePath: classPath, routerWhiteFilePath: whitePath)
}

/// 根据路由名进行跳转
/// - Parameters:
///   - routerName: 路由名
///   - params: 参数
public func AJRouterName(routerName:String, params:[String:String]?) {
    var paramsString = "参数为空"
    if let array = params {
        if let string = JSON(array).string {
            paramsString = string
        }
    }
    if AJRouterNameCall(routerName: routerName, params: params) {
        AJPrintLog("跳转成功\nrouterName:\(routerName)\nparams:\(paramsString)")
        return;
    }
    AJPrintLog("跳转失败\nrouterName:\(routerName)\nparams:\(paramsString)")
}

/// 根据路由名进行跳转,有返回值 YES:跳转成功
/// - Parameters:
///   - routerName: 路由名
///   - params: 参数
public func AJRouterNameCall(routerName:String, params:[String:String]?) -> Bool {
    return AJRouterMananger.shared.routerWithName(routerName: routerName, params: params)
}

/// 根据路由url进行跳转
/// - Parameters:
///   - routerUrl: 路由url
///   - params: 参数
public func AJRouterUrl(routerUrl:String, params:[String:String]?) {
    var paramsString = "参数为空"
    if let array = params {
        if let string = JSON(array).string {
            paramsString = string
        }
    }
    if AJRouterUrlCall(routerUrl: routerUrl, params: params) {
        AJPrintLog("跳转成功\nrouterName:\(routerUrl)\nparams:\(paramsString)")
        return;
    }
    AJPrintLog("跳转失败\nrouterName:\(routerUrl)\nparams:\(paramsString)")
}

/// 根据路由url进行跳转,有返回值 YES:跳转成功
/// - Parameters:
///   - routerUrl: 路由url
///   - params: 参数
public func AJRouterUrlCall(routerUrl:String, params:[String:String]?) -> Bool {
    return AJRouterMananger.shared.routerWithUrl(routerUrl: routerUrl, params: params)
}

// 返回N级页面
public func AJRouterPop(index:Int) {
    AJRouterMananger.shared.popRouter(index: index)
}

/// 返回指定路由页面
/// - Parameters:
///   - url: 路由
///   - animated: 是否有转场动画
public func AJRouterPop(routerUrl:String, animated:Bool) {
    AJRouterMananger.shared.popRouter(routerUrl: routerUrl, animated: animated)
}

/// 根据url获取页面名称
/// - Parameter routerUrl: 路由url
public func AJRouterPageNameWithUrl(routerUrl:String) -> String? {
    return AJRouterMananger.shared.pageNameWithUrl(routerUrl: routerUrl)
}
