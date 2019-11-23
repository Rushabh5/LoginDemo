//
//  Constants.swift
//  Demo
//
//  Created by Rushabh Shah on 10/8/19.
//  Copyright © 2019 Rushabh Shah. All rights reserved.
//

import Foundation

typealias voidCompletion = (()->Void)
typealias StringAny = [String: Any]
typealias Loading = (showLoader: Bool, showTransparentView: Bool)


final class Constants {
    
    static func getString(from value: Any?) -> String {
        if let val = value, let stringValue = val as? String {
            return stringValue
        }
        return ""
    }
}
