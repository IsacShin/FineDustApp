//
//  MainVM.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/02.
//

import Foundation
import ReactorKit
import SwiftyJSON

class MainVM: Reactor, HasMiseService {
    let miseService: MiseService = MiseService()
    
    var initialState: State = State()
    
    enum Action {
        case reqMiseAPI(Int,Int,String)
    }
    
    enum Mutation {
        case mises([MiseModel])
    }
    
    struct State {
        var mises:[MiseModel] = []
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .reqMiseAPI(let startDate, let endDate, let locationName):
            return self.miseService.rx.reqMiseAPI(startDate: startDate, endDate: endDate, locationName: locationName)
                .map { Mutation.mises($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .mises(let mises):
            newState.mises = mises
            return newState
        }
    }
}
