//
//  DateExt.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/02.
//

import Foundation

extension Date {
    /// 날짜 변환 : 날짜 포멧
    func getFormatTime() -> Int {
        
        let format = "yyyyMMdd"
        let date = self.toString(format:format)
        
        return Int(date) ?? 0
    }
    
    /// 스트링 변환 : 날짜 포멧
    func toString(format:String, am:String? = nil, pm:String? = nil)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.dateFormat = format
        
        if let amSymbol = am {
            dateFormatter.amSymbol = amSymbol
        }
        if let pmSymbol = pm {
            dateFormatter.pmSymbol = pmSymbol
        }
            
        return dateFormatter.string(from: self)
    }
}
