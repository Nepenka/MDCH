//
//  SceneDelegate.swift
//  MDCH
//
//  Created by 123 on 4.01.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {return}
        let window = UIWindow(windowScene: windowScene)
        let vc = LoginController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        window.rootViewController = nav
        self.window = window
        self.window?.makeKeyAndVisible()
        
        let userRequest = RegisterUserRequest(username: "Logan",
                                              email: "vlad@gmail.com",
                                              password: "password123")
        AuthService.shared.registerUser(with: userRequest) { wasRegistered, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("wasRegistered", wasRegistered)
        }
    }
    

}

