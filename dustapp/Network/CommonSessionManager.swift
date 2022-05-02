//
//  CommonSessionManager.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/02.
//

import Foundation
import Alamofire

class CommonSessionManager: Alamofire.Session {
    static let sharedManager: CommonSessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 30 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 30 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return CommonSessionManager(configuration: configuration)
    }()
}
