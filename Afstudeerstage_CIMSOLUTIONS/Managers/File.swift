//
//  File.swift
//  Afstudeerstage_CIMSOLUTIONS
//
//  Created by Kevin Kentie on 14/04/2021.
//

import Foundation
import UIKit

func returnToLogin(controller : UIViewController,_ sender: Any) {
    UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
    UserDefaults.standard.synchronize()
    controller.tabBarController?.tabBar.isHidden = true
    controller.navigationController?.navigationBar.isHidden = true
}
