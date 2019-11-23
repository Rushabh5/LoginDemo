//
//  NetworkingSetup.swift
//  LCOnline
//
//  Created by Rushabh Shah on 4/22/19.
//  Copyright © 2019 Rushabh Shah. All rights reserved.
//

import Foundation
import Alamofire

typealias ParameterKey = NetworkingSetup.APIParameterKey
typealias HTTPHeaderField = NetworkingSetup.HTTPHeaderField
typealias ContentType = NetworkingSetup.ContentType
typealias PageLimit = NetworkingSetup.PageLimit
let PAGINATION_LIMIT = 25

struct NetworkingSetup {
    
    static let currentAppState: AppState = .development
    
    enum AppState {
        case production
        case staging
        case development
        
        var serverUrl: String {
            switch self {
            case .production:
                return ""
            case .staging:
                return ""
            case .development:
                return "http://192.99.13.59:8081/user/v2/"
            }
        }
        
    }
    
    struct APIParameterKey {
        static let user_id = "user_id"
        static let password = "password"
    }
    
    struct HTTPHeaderField {
        static let contentType = "Content-Type"
    }
    
    struct ContentType {
        static let json = "application/json"
    }
    
    struct PageLimit {
        let page: Int
        var limit: Int = PAGINATION_LIMIT
        init(page: Int, limit: Int = PAGINATION_LIMIT) {
            self.page = page
            self.limit = limit
        }
    }
    
}


