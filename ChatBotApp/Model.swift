//
//  Model.swift
//  ChatBotApp
//
//  Created by 김은지 on 2023/06/13.
//

import Foundation

struct ResponseMessage: Decodable {
    let atext: String?
    let lang: String?
    let request: RequestData
    
    enum CodingKeys: String, CodingKey {
        case atext
        case lang
        case request
        
    }
    
}

struct RequestData: Decodable {
    var utext: String?
    var lang: String?
    
    enum CodingKeys: String, CodingKey {
        case utext
        case lang
        
    }
    
    
}
