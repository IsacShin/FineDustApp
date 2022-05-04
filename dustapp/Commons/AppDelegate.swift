//
//  AppDelegate.swift
//  dustapp
//
//  Created by 신이삭 on 2022/05/02.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationVC:UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.initNavigationVC()
        return true
    }

}

extension AppDelegate {
    func initNavigationVC() {
        self.navigationVC = UINavigationController()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationVC?.setViewControllers([mainVC], animated: false)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = navigationVC
        self.window!.makeKeyAndVisible()
    }
}
