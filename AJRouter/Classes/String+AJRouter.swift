//
//  String+AJRouter.swift
//  AJRouter
//
//  Created by 徐结兵 on 2019/11/24.
//

import Foundation

extension String {
    func openInSafari() -> Bool {
        if self.isEmpty {
            return false
        }
        guard let url = URL.init(string: self) else {
            return false
        }
        guard !UIApplication.shared.canOpenURL(url) else {
            AJPrintLog("打开系统自带浏览器时, URL格式传的不对, URL是:\(self)")
            return false;
        }
        return UIApplication.shared.openURL(url);
    }
}
