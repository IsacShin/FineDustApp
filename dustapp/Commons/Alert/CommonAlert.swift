//
//  CommonAlert.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/02.
//

import Foundation
import UIKit

class CommonAlert {
    //일반 alert type
    static func showAlertType1(vc:UIViewController, title:String = "", message:String = "", completeTitle:String = "", _ completeHandler:(() -> Void)?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        let action1 = UIAlertAction(title:completeTitle, style: .default) { action in
            completeHandler?()
        }
        alert.addAction(action1)
        vc.present(alert, animated: true, completion: nil)
    }
    
    //일반 confirm type
    static func showAlertType2(vc:UIViewController, title:String = "", message:String = "", cancelTitle:String = "", completeTitle:String = "",  _ cancelHandler:(() -> Void)? = nil, _ completeHandler:(() -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertController.Style.alert)
        let action1 = UIAlertAction(title:cancelTitle, style: .cancel) { action in
            cancelHandler?()
        }
        let action2 = UIAlertAction(title:completeTitle, style: .default) { action in
            completeHandler?()
        }
        alert.addAction(action1)
        alert.addAction(action2)
        vc.present(alert, animated: true, completion: nil)
    }
}
