//
//  UserEndPoint.swift
//  LCOnline
//
//  Created by Rushabh Shah on 4/22/19.
//  Copyright © 2019 Rushabh Shah. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

struct APIClient {

    @discardableResult
    private static func performRequest<T:Decodable>(route: APIRouter, doShowLoading: Loading = (true, false), decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, AFError>) -> Void) -> DataRequest {
        print("Request: ")
        debugPrint(route.urlRequest!)
        if let body = route.urlRequest?.httpBody {
            print(String(data: body, encoding: .utf8) ?? "")
        }
        if doShowLoading.showLoader {
            LoadingView.showLoading()
        }
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                LoadingView.hideLoading()
                completion(response.result)
        }
    }
    
    private static func handleResponse(result: (Result<CoreResponseData, AFError>)) -> Result<CoreResponseData, AppError> {
        switch result {
        case .success(let data):
            let appError = AppError(returnStatus: data.returnStatus, message: data.message, data: data.data, error: nil)
            if let returnStatus = data.returnStatus, !returnStatus {
                return .failure(appError)
            }
            return .success(data)
        case .failure(let err):
            return .failure(AppError(returnStatus: nil, message: nil, data: nil, error: err))
        }
    }
    
    static func performLogin(withUserId userId: String, password: String, doShowLoading: Loading = (true, false), completion: @escaping (Result<CoreResponseData, AppError>) -> Void){
        performRequest(route: APIRouter.login(userId: userId, password: password), doShowLoading: doShowLoading, completion: { completion(handleResponse(result: $0)) })
    }
    
    
}
