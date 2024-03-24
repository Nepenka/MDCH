//
//  SettingViewController.swift
//  MDCH
//
//  Created by 123 on 24.03.24.
//

import UIKit
import SnapKit


class SettingController: UIViewController {
    
    let editButton = CustomButton(title: "Edit", hasBackground: false, fontSize: .small)
  //  let nameLabel = CustomLabel(text: , textColor: <#T##UIColor#>, fontSize: <#T##FontSize#>, fontStyle: <#T##FontStyle#>)
    let avatarImage = UIImageView(image: UIImage(named: "default_image"))
   // let defaultAvatar = UIImage(named: "default_image")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(editButton)
        view.addSubview(avatarImage)
        
        editButton.snp.makeConstraints { edit in
            edit.top.equalToSuperview().offset(65)
            edit.right.equalToSuperview().offset(80)
            edit.left.equalToSuperview().offset(200)
        }
        
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
        avatarImage.clipsToBounds = true
        
        avatarImage.snp.makeConstraints { avatarImage in
            avatarImage.top.equalTo(editButton.snp.bottom).offset(10)
            avatarImage.left.right.equalToSuperview().inset(55)
            avatarImage.bottom.equalToSuperview().inset(120)
            
        }
         
        
    }
}
