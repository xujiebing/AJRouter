//
//  File.swift
//  AJRouter
//
//  Created by 徐结兵 on 2019/11/28.
//

import Foundation

extension NSObject {
    var className:String {
        get {
            var name = type(of: self).description()
            if name.contains(".") {
               name = name.components(separatedBy: ".")[1]
            }
            return name
        }
    }
}
