//
//  ViewController.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/02.
//

import UIKit
import ReactorKit
import RxViewController

var colors = ["#6799FF","#3DB7CC","#F29661","#DF4D4D"]
var icons = ["happy","sad","super-angry","bad"]
var status = ["좋음","보통","나쁨","매우나쁨"]

class MainVC: UIViewController, StoryboardView {
    
    var disposeBag: DisposeBag = DisposeBag()
    var mises:[MiseModel] = []
    var status:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = MainVM()
    }
    
    func bind(reactor: MainVM) {
        // View
        
        // Action
        let endDate:Int = Date().getFormatTime()
        self.rx.viewWillAppear
            .observe(on: MainScheduler.instance)
            .map{_ in Reactor.Action.reqMiseAPI(20220101, endDate, "구로구")}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        
        // State
        reactor.state
            .map{ $0.mises }
            .do(onNext: { (item) in
                if item.isEmpty {
                    print("데이터 없음")
                }
            })
            .filter{ $0.isEmpty == false }
            .subscribe { (mises) in
                self.mises = mises.element!
                self.status = self.getStatus(mise: self.mises.first!)
            }.disposed(by: disposeBag)
    }

    func getStatus(mise:MiseModel) -> Int {

        if mise.pm10 ?? 0 > 150 {
            return 3
        }else if mise.pm10 ?? 0 > 80 {
            return 2
        }else if mise.pm10 ?? 0 > 30 {
            return 1
        }
        
        return 0
    }
    
    func setLayoutMainView() {
        
    }

}

