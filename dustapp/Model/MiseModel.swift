//
//  MiseModel.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/02.
//

import Foundation
import SwiftyJSON
import ObjectMapper


class MiseModel:Codable {
    var pm10:String?
    var pm25:String?
    var dateTime:String?
    
    init(jsonData:JSON) {
        pm10 = jsonData["pm10Value"].string ?? ""
        pm25 = jsonData["pm25Value"].string ?? ""
        dateTime = jsonData["msurDt"].string ?? ""
    }
    
    
}
