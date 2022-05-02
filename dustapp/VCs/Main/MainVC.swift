//
//  ViewController.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/02.
//

import UIKit
import ReactorKit
import RxViewController
import Hex

var colors = ["#6799FF","#3DB7CC","#F29661","#DF4D4D"]
var icons = ["happy","sad","super-angry","bad"]
var statusArr = ["좋음","보통","나쁨","매우나쁨"]

class MainVC: UIViewController, StoryboardView {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusAirLabel: UILabel!
    
    var disposeBag: DisposeBag = DisposeBag()
    var mises:[MiseModel] = []
    var status:Int = 0
    var locationName:String = "구로구"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = MainVM()
    }
    
    func bind(reactor: MainVM) {
        // View
        self.stackView.removeAllArrangedSubviews()
        self.view.backgroundColor = UIColor(hex: colors[0])
        self.locationLabel.text = ""
        self.statusImg.image = UIImage(named: icons[0])
        self.statusLabel.text = ""
        self.statusAirLabel.text = ""
        
        // Action
        let endDate:Int = Date().getFormatTime()
        self.rx.viewWillAppear
            .observe(on: MainScheduler.instance)
            .map{_ in Reactor.Action.reqMiseAPI(20220101, endDate, self.locationName)}
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
        
        self.view.backgroundColor = UIColor(hex: colors[status])
        self.locationLabel.text = "[\(self.locationName)]"
        self.statusImg.image = UIImage(named: icons[status])
        self.statusLabel.text = statusArr[status]
        self.statusAirLabel.text = "\(String(describing: self.mises.first!.pm10))ug/m2"
        
        for item in self.mises {
            if let v = Bundle.main.loadNibNamed("DustView", owner: nil, options: nil)?.first as? DustView {
                v.dateLbl.text = item.dateTime
                v.dustImg.image = UIImage(named: icons[self.getStatus(mise: item)])
                v.dustLbl.text = "\(String(describing: item.pm10))ug/m2"
                
                self.stackView.addArrangedSubview(v)
            }
        }
        
    }

}

