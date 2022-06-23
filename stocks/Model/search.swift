//
//  search.swift
//  stocks
//
//  Created by 홍태희 on 2022/06/23.
//

import Foundation
import Moya

//search를 할 때 code를 입력하여 종목명을 찾는다.

struct search : Codable {
    var event : String //종목명
}

enum searches {
    case event
}

extension searches : TargetType {
    
    var baseURL: URL {
        return URL(string: baseAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .event :
            return "/stock/{event}"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .event :
            return .get
        }
    }
    
    var task: Task { //Task에 대한 이해도 필요
        switch self {
        case .event :
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default :
            return ["Content-Type" : "application/json"]
        }
    }
    
    
}


