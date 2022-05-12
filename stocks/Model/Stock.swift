//
//  Stock.swift
//  stocks
//
//  Created by 홍태희 on 2022/05/12.
//

import UIKit
import Moya

struct basesAPI {
    static let baseURL = "https://{BASE_URL}/" //주식 리스트
}

struct stocks : Codable {
    var name : String //제목
    var currentPrice : Int //현재가
    var upsidePredictionRate : String //상승률
    var tradingVolume : String //거래량
    
    init(_ name : String, _ currentPrice : Int, _ upsidePredictionRate : String, _ tradingVolume : String){
        self.name = name
        self.currentPrice = currentPrice
        self.upsidePredictionRate = upsidePredictionRate
        self.tradingVolume = tradingVolume
    }
}

enum moneyGraph {
    case name
    case currentPrice
    case upsidePredictionRate
    case tradingVolume
}

extension moneyGraph : TargetType {
    
    var baseURL: URL {
        return URL(string: basesAPI.baseURL)!
    }
    
    var path: String {
        switch self {
        case .name:
            return "stock/"
        case .currentPrice:
            return "stock/"
        case .upsidePredictionRate:
            return "stock/"
        case .tradingVolume:
            return "stock/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .name, .currentPrice, .upsidePredictionRate, .tradingVolume :
            return .get
        }
    }
    
    // 이 부분이 이해가안감.. ( 임시로 리턴은 requestPlain으로 설정 )
    var task: Task {
        switch self {
        case .name :
            return .requestPlain
        case .currentPrice :
            return .requestPlain
        case .upsidePredictionRate :
            return .requestPlain
        case .tradingVolume :
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

