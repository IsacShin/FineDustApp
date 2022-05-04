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
import SnapKit

var colors = ["#4375DB","#3DB7CC","#F29661","#DF4D4D"]
var icons = ["happy","sad","super-angry","bad"]
var statusArr = ["좋음","보통","나쁨","매우나쁨"]

class MainVC: UIViewController, StoryboardView {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusAirLabel: UILabel!
    @IBOutlet weak var floatyView: UIView!
    
    @IBOutlet weak var scrollview: UIScrollView! {
        didSet {
            self.scrollview.contentInset = .init(top: 0, left: 0, bottom: 40, right: 0)
        }
    }
    
    
    var disposeBag: DisposeBag = DisposeBag()
    var mises:[MiseModel] = []
    var status:Int = 0
    var locationName:String = "강남구"

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
        self.floatyView.layer.cornerRadius = self.floatyView.frame.width/2
        
        // Action
        let date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) // 30일 이전 기록만 표기
        
        self.rx.viewWillAppear
            .observe(on: MainScheduler.instance)
            .map{_ in Reactor.Action.reqMiseAPI(date!.getFormatTime(), Date().getFormatTime(), self.locationName)}
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
                DispatchQueue.main.async {
                    self.setLayoutMainView()
                }
            }.disposed(by: disposeBag)
    }

    func getStatus(mise:MiseModel) -> Int {
        
        guard let pm10 = mise.pm10 else { return  0 }
        
        if Int(pm10) ?? 0 >= 75 {
            return 3
        }else if Int(pm10) ?? 74 >= 50 {
            return 2
        }else if Int(pm10) ?? 49 >= 40 {
            return 1
        }else if Int(pm10) ?? 39 >= 0 {
            return 0
        }
        
        return 0
    }
    
    func setLayoutMainView() {
        
        self.stackView.removeAllArrangedSubviews()
        self.view.backgroundColor = UIColor(hex: colors[status])
        self.locationLabel.text = "[\(self.locationName)]"
        self.statusImg.image = UIImage(named: icons[status])
        self.statusLabel.text = statusArr[status]
        self.statusAirLabel.text = "\(self.mises.first!.pm10 ?? "")ug/m2"
        self.stackView.spacing = 20
        
        for item in self.mises {
            if let v = Bundle.main.loadNibNamed("DustView", owner: nil, options: nil)?.first as? DustView {
                v.backgroundColor = .clear
                v.dateLbl.text = item.dateTime
                v.dustImg.image = UIImage(named: icons[self.getStatus(mise: item)])
                v.dustLbl.text = "\(item.pm10 ?? "")ug/m2"
                
                self.stackView.addArrangedSubview(v)
            }
        }
        
    }

}

extension MainVC {

    @IBAction func locationBtnPressed(_ sender: Any) {
        CommonNav.moveLocationVC(parentVC: self)
    }

}
