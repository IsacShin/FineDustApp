//
//  LocationView.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/04.
//

import Foundation
import UIKit

class LocationView:UIView {
    @IBOutlet weak var locationName: UILabel!
    var btnHandler:(() -> Void)?
   
    @IBAction func locationBtnPressed(_ sender: Any) {
        if let handler = btnHandler {
            handler()
        }
    }
}
