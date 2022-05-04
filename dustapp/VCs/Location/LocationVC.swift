//
//  LocationVC.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/04.
//

import UIKit
import ReactorKit
import RxViewController

class LocationVC: UIViewController, StoryboardView {

    var disposeBag: DisposeBag = DisposeBag()
    var parentVC:UIViewController?
    var loctaionList:[String] = []
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reactor = LocationVM()
    }
    
    func bind(reactor: LocationVM) {
        // View
        self.loctaionList = try! self.parsePlist()
        
        self.stackView.removeAllArrangedSubviews()
        for item in self.loctaionList {
            if let view = Bundle.main.loadNibNamed("LocationView", owner: nil, options: nil)?.first as? LocationView {
                view.locationName.text = item
                view.btnHandler = {
                    if let mainVC = self.parentVC as? MainVC {
                        mainVC.locationName = item
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                
                self.stackView.addArrangedSubview(view)
            }
        }
        
        // Action
       
        // State
       
    }

}

extension LocationVC {
    func parsePlist() throws -> [String] {
        let url = Bundle.main.url(forResource: "LocationList", withExtension: "plist")!
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([String].self, from: data)
            return result.sorted() as [String]
        } catch {
            throw error
        }
    }
}
