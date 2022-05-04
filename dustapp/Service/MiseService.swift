//
//  MiseService.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/02.
//

import Foundation
import RxSwift
import SwiftyJSON
import Alamofire
import Moya

protocol HasMiseService {
    var miseService: MiseService { get }
}

class MiseService {
    let provider = MoyaProvider<CallAPI>(requestClosure:
        { (endpoint: Endpoint, done: @escaping MoyaProvider<CallAPI>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 30
                done(.success(request))
            } catch {
                return
            }
        }
        , session: CommonSessionManager.sharedManager ,plugins: [NetworkActivityPlugin(networkActivityClosure: {
        (_ change: NetworkActivityChangeType, _ target: TargetType) in
        switch change {
        case .began:
            print("startAPI...")
        case .ended:
            print("endAPI!")
        }
    })])
    
    fileprivate func reqMiseAPI(startDate:Int, endDate:Int, locationName:String) -> Observable<[MiseModel]> {
        return Observable.create { observer -> Disposable in
            self.provider.request(.reqMiseAPI(startDate: startDate, endDate: endDate, locationName: locationName)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    do {
                        var mises = [MiseModel]()
                        let resultJson = try! JSON(data: response.data)
                        print(resultJson)
                        let items = resultJson["response"]["body"]["items"]
                        for i in 0..<items.count {
                            mises.append(MiseModel(jsonData: items[i]))
                        
                        }
                        
                        observer.onNext(mises)
                    }
                case .failure(let err):
                    print("통신 오류:\(err)")
                }
            }
            
            return Disposables.create()
        }
    }
}

extension MiseService: ReactiveCompatible {}

extension Reactive where Base: MiseService {
    func reqMiseAPI(startDate:Int, endDate:Int, locationName:String) -> Observable<[MiseModel]> {
        return base.reqMiseAPI(startDate: startDate, endDate: endDate, locationName: locationName)
    }
}
