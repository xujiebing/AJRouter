//
//  AJRouterProtocol.swift
//  AJRouter
//
//  Created by 山鹰 on 2022/9/4.
//

import Foundation

@objc
public protocol AJRouterProtocol {
    @objc optional func ajSetParameter(_ parameters: AnyObject)
}
