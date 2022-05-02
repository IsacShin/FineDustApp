//
//  CallAPI.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/02.
//

import Foundation
import Moya

let SERVICEKEY = "obizPjapZ%2BQV5sqk1Pg5Fdy04SGPlCqKb4aBuRCvXoUPWf%2BI3uWveYvJGgvPgrMcgB4XcymscFgpWmo4F4f10w%3D%3D"

public enum CallAPI {
    case reqMiseAPI(startDate:Int, endDate:Int, locationName:String)
}

extension CallAPI:TargetType {

    public var baseURL: URL {
        return URL(string: "http://apis.data.go.kr")!
    }
    
    public var path: String {
        switch self {
        case .reqMiseAPI(_, _, _):
            return "/B552584/ArpltnStatsSvc/getMsrstnAcctoRDyrg"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .reqMiseAPI(_, _, _):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var parameters:[String:Any]? {
        switch self {
        case .reqMiseAPI(let startDate, let endDate, let locationName):
            return [
                "pageNo" : 1,
                "numOfRows" : 100,
                "returnType" : "json",
                "serviceKey" : SERVICEKEY.removingPercentEncoding!,
                "inqBginDt" : startDate,
                "inqEndDt" : endDate,
                "msrstnName" : locationName
            ]
        }
    }
    
    public var task: Task {
        switch self {
        case .reqMiseAPI(_, _, _):
            return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var validationType: ValidationType {
        return .customCodes([200,500])
    }
}
