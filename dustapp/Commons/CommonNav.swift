//
//  CommonNav.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/04.
//

import Foundation
import UIKit

class CommonNav:NSObject {
    static func moveLocationVC(parentVC:UIViewController?) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LocationVC") as? LocationVC {
            
            vc.parentVC = parentVC
            
            // Push
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.navigationVC?.pushViewController(vc, animated: true)
            }
        }
    }
}
