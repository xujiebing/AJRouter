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
    
    init(url:String) {
        super.init()
        
        
    }
    
    func addParameters(url:String, params:[AnyHashable:Any])  {
        
    }
    

}

