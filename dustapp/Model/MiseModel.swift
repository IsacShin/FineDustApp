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
    var pm10:Int?
    var pm25:Int?
    var khai:Int?
    var dateTime:String?
    var so:Double?
    var co:Double?
    var no:Double?
    var o3:Double?
    
    init(jsonData:JSON) {
        pm10 = jsonData["pm10Value"].int ?? 0
        pm25 = jsonData["pm25Value"].int ?? 0
        khai = jsonData["khaiGrade"].int ?? 0
        dateTime = jsonData["msurDt"].string ?? ""
    }
    
    
}
