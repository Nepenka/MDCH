//
//  MainTabBarController.swift
//  MDCH
//
//  Created by 123 on 24.03.24.
//

import UIKit


class TabBarController: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
    }
    
    
    private func setupTabs() {
        let searchUsers = createNav(with: "Search", and: UIImage(systemName: "person.crop.circle.fill.badge.questionmark"), vc: SearchUserController())
        let news = createNav(with: "Newsfeed", and: UIImage(systemName: "magazine.fill"), vc: NewsController())
        let message = createNav(with: "Message", and: UIImage(systemName: "message.circle.fill"), vc: MessageController())
        let settings = createNav(with: "Settings", and: UIImage(systemName: "gearshape.circle.fill"), vc: SettingController())
        
        self.setViewControllers([searchUsers, news, message, settings], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
}
