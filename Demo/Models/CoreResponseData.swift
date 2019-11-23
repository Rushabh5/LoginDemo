//
//  ResponseData.swift
//  LCOnline
//
//  Created by Rushabh Shah on 4/26/19.
//  Copyright © 2019 Rushabh Shah. All rights reserved.
//

import Foundation

struct AppError: Error {
    
    let returnStatus : Bool?
    let message : String?
    let data: Any?
    let error: Error?
    
    func getResponseDictionary() -> StringAny? {
        return data as? StringAny
    }
    func getResponseArryDictionary() -> [StringAny]? {
        return data as? [StringAny]
    }
}

struct CoreResponseData : Codable {
    
    var returnStatus: Bool?
    var message : String?
    var data : Any?
    
    enum CodingKeys: String, CodingKey {
        case returnStatus = "returnStatus"
        case status = "status"
        case message = "message"
        case data = "data"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        returnStatus = try values.decodeIfPresent(Bool.self, forKey: .returnStatus)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        if let stringAny = try? values.decode(StringAny.self, forKey: .data) {
            data = stringAny
        } else if let stringAny = try? values.decode([Any].self, forKey: .data) {
            data = stringAny
        }
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    init() {
        self.returnStatus = nil
        self.message = nil
        self.data = nil
    }
    
    func getResponseDictionary() -> StringAny? {
        return data as? StringAny
    }
    
    func getResponseArryDictionary() -> [StringAny]? {
        return data as? [StringAny]
    }
    
}
