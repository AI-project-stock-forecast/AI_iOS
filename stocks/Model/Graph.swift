//
//  Graph.swift
//  stocks
//
//  Created by 홍태희 on 2022/05/15.
//

import UIKit
import Moya

//주식가격, 주식가격예측
//code를 입력하면 정보가 띄워진다고함.

struct datas : Codable {
    var title : String //제목 (주식가격예측)
    var description : String //내용 (주식가격예측)
    
    var code : String //코드 (주식가격)
}

enum result {
    case title
    case description
    
    case code
}

extension result : TargetType {
    
    var baseURL: URL {
        return URL(string: baseAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .title, .description:
            return "/stock/prediction/{code}"
            
        case .code:
            return "/stock/price/{code}"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .title, .description :
            return .get
            
        case .code :
            return .get
        }
    }
    
    var task: Task { //Task에 대한 이해도 필요
        switch self {
        case .title, .description :
            return .requestPlain
            
        case .code :
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

