//
//  SceneDelegate.swift
//  MDCH
//
//  Created by 123 on 6.02.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {return}
        let window = UIWindow(windowScene: windowScene)
        let vc = WelcomController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        window.rootViewController = nav
        self.window = window
        self.window?.makeKeyAndVisible()
    }

}

