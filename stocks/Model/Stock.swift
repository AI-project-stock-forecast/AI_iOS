//
//  Stock.swift
//  stocks
//
//  Created by 홍태희 on 2022/05/12.
//

import UIKit
import Moya

struct baseAPI {
    static let baseURL = "http://15.164.56.76:8000"
}

enum moneyGraph {
    //한 명세에 하나의 case ( 제발 각각 넣지 마세요 )
    case getList
    case searchCode(_ event: String)
    case getPrice(_ code: String)
    case prediction(_ code: String)
}

extension moneyGraph : TargetType {
    
    var baseURL: URL {
        return URL(string: baseAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/stock"
        case .searchCode(let event):
            return "/stock/\(event)"
        case .getPrice(let code):
            return "stock/price/\(code)"
        case .prediction(let code):
            return "stock/prediction/\(code)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task { 
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return [:]
    }
}

