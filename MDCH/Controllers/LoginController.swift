//
//  LoginController.swift
//  MDCH
//
//  Created by 123 on 17.02.24.
//

import UIKit
import SnapKit




class LoginController: UIViewController {
    
    //MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign In", subTitle: "Sign in to your account")
    private let usernameField = CustomTextField(authFieldType: .username)
    private let passwordField = CustomTextField(authFieldType: .password)
    private let buttonAction = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    
    //MARK: - LifeCycle
    
    //MARK: - UI Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupUI()
        
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(headerView)
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(buttonAction)
        
        headerView.snp.makeConstraints { header in
            header.top.equalTo(view.snp.top)
            header.leading.equalTo(view.snp.leading)
            header.trailing.equalTo(view.snp.trailing)
            header.height.equalTo(270)
        }
        
        usernameField.snp.makeConstraints { nameField in
            nameField.top.equalTo(headerView.snp.bottom).offset(45)
            nameField.centerX.equalTo(headerView.snp.centerX)
            nameField.height.equalTo(55)
            nameField.width.equalToSuperview().multipliedBy(0.85)
        }
        
        passwordField.snp.makeConstraints { password in
            password.top.equalTo(usernameField.snp.bottom).offset(25)
            password.centerX.equalTo(headerView.snp.centerX)
            password.height.equalTo(55)
            password.width.equalToSuperview().multipliedBy(0.85)
        }
        
        buttonAction.snp.makeConstraints { button in
            button.top.equalTo(passwordField.snp.bottom).offset(25)
            button.centerX.equalTo(headerView.snp.centerX)
            button.height.equalTo(55)
            button.width.equalToSuperview().multipliedBy(0.85)
        }
        
        
        
    }
    
    //MARK: - Selectors
}
