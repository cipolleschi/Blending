//
//  AppDelegate.swift
//  BlendingArticle
//
//  Created by Riccardo Cipolleschi on 30/10/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    let tabbarVC = UITabBarController()
    let blendModeVC = BlendModeVC()
    blendModeVC.tabBarItem = UITabBarItem(title: "blendMode", image: nil, tag: 0)

    let compositingVC = CompositingVC()
    compositingVC.tabBarItem = UITabBarItem(title: "compositing", image: nil, tag: 1)

    tabbarVC.addChild(blendModeVC)
    tabbarVC.addChild(compositingVC)


    let window = UIWindow()
    window.rootViewController = tabbarVC
    self.window = window
    self.window?.makeKeyAndVisible()

    return true
  }


}

