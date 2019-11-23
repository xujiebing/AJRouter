//
//  AJRouterManager.swift
//  AJRouter
//
//  Created by 徐结兵 on 2019/10/29.
//

import Foundation

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
            let object = try AJRouterTool.loadJsonFileWithPath(path: classPath!)
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
            let object = try AJRouterTool.loadJsonFileWithPath(path: whitePath!)
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
    static let shared = AJRouterMananger.init()
    private override init(){
        super.init()
    }

    // 设置路由文件路径
    func routerFilePaths(routerNameFilePath namePath:String, routerClassFilePath classPath:String, routerWhiteFilePath whitePath: String) {
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
    
    // 根据路由名进行跳转
    func routerWithName(routerName name:String, params:[String:String]?) -> Bool {
        let routerUrl = AJRouterTool.routerUrlWithName(routerName: name)
        guard routerUrl != nil else {
            return false;
        }
        return self.routerWithUrl(routerUrl: routerUrl!, params: params)
    }
    
    // 根据路由url进行跳转
    func routerWithUrl(routerUrl url:String, params:[String:String]?) -> Bool {
        if url.hasPrefix("http://") || url.hasPrefix("https://") {
            return AJRouterTool.openUrlInSafari(urlString: url)
        }
        let model = AJRouterModel.modelWithUrl(url: url, params: params)
        if model == nil {
            return false
        }
        guard AJRouterTool.checkParams(model: model!) else {
            return false
        }
        return self.router(routerModel: model!);
    }
    
    // 返回上级页面
    func popRouter() {
        let currentVC = UIViewController.currentViewController()
        if (currentVC.presentingViewController != nil) && currentVC.navigationController?.viewControllers.count == 1 {
            currentVC.dismiss(animated: true, completion: nil)
        } else {
            currentVC.navigationController?.popViewController(animated: true)
        }
        if let _ = currentVC.presentingViewController {
            if let nav = currentVC.navigationController {
                if nav.viewControllers.count == 1 {
                    currentVC.dismiss(animated: true, completion: nil)
                } else {
                    nav.popViewController(animated: true)
                }
            } else {
                currentVC.dismiss(animated: true, completion: nil)
            }
        } else {
            currentVC.navigationController!.popViewController(animated: true)
        }
    }
    
    // 返回N级页面
    func popRouter(index:Int) {
        if (index <= 0) {
            return;
        }
        let currentVC = UIViewController.currentViewController()
        if let nav = currentVC.navigationController {
            let vcArray = nav.viewControllers
            let count = vcArray.count
            if index + 1 >= count {
                if let presentVC = currentVC.presentingViewController {
                    currentVC.dismiss(animated: true) {
                        self.popRouter(index: index - count)
                    }
                    return;
                }
                nav.popToRootViewController(animated: true)
                return
            }
            let realIndex = count - index - 1
            
//            id targetVC = NSArray.dbObjectAtIndex(vcArray, index);
//            if (!targetVC) {
//                return;
//            }
//            if (![targetVC isKindOfClass:[UIViewController class]]) {
//                return;
//            }
//            [lastVC.navigationController popToViewController:targetVC animated:YES];
            
            return;
        }
        if let presentVC = currentVC.presentingViewController {
            currentVC.dismiss(animated: true, completion: nil)
        }
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
                    complete = AJRouterTool.switchTabBarIndex(index: index)
                }
                return complete
            }
            return false
        }
        guard let vc = AJRouterTool.viewControllerWithModel(model: routerModel) else {
            return false
        }
        let complete = AJRouterTool.jumpPageWithViewController(viewController: vc, jumpType: routerModel.jumpType)
        return complete
    }
}

