//
//  APIRouter.swift
//  LCOnline
//
//  Created by Rushabh Shah on 4/22/19.
//  Copyright © 2019 Rushabh Shah. All rights reserved.
//

import UIKit
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case login(userId: String, password: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
            case .login: return "Login"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let userId, let password):
            return [ParameterKey.user_id: userId, ParameterKey.password: password.html2String]
        }
    }
    
    //MARK: - Headers
    private var headers: HTTPHeaders {
        return HTTPHeaders([HTTPHeaderField.contentType: ContentType.json])
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkingSetup.currentAppState.serverUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        if let param = parameters {
            do {
                let jsonParam = try JSONSerialization.data(withJSONObject: param, options: .fragmentsAllowed)
                if var str = String(data: jsonParam, encoding: .utf8) {
                    str = str.replacingOccurrences(of: "\\", with: "")
                    urlRequest.httpBody = str.data(using: .utf8)
                } else {
                    urlRequest.httpBody = jsonParam
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return urlRequest
    }
}

extension MultipartFormData {
    func add(key: String, value: String?) {
        if let val = (value ?? "").data(using: .utf8) {
            append(val, withName: key)
        }
    }
}
