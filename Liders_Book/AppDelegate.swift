//
//  AppDelegate.swift
//  Liders_Book
//
//  Created by Firdavs Zokirov  on 17/08/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let vc = SignUpVC(nibName: "SignUpVC", bundle: nil)
        let reading = ReadingVC(nibName: "ReadingVC", bundle: nil)
        if (UserDefaults.standard.string(forKey: Keys.isLogged) != nil){
            let nav = UINavigationController(rootViewController: reading)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
        else{
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    
}

