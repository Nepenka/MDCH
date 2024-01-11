//
//  LoginController.swift
//  MDCH
//
//  Created by 123 on 10.01.24.
//

import UIKit
import SnapKit

class LoginController: UIViewController {
    //MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign In", subtitle: "Sign in to your account")
    
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    private let signInButton = CustomButton(title: "Sign In",hasBackground: true ,fontSize: .big)
    private let newUserButton = CustomButton(title: "New User? Create Account", fontSize: .medium)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
                                                
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        
    }

    //MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        self.view.addSubview(newUserButton)
        self.view.addSubview(forgotPasswordButton)
        
        headerView.snp.makeConstraints { header in
            header.top.equalTo(self.view.layoutMarginsGuide.snp.top)
            header.leading.equalTo(self.view.snp.leading)
            header.trailing.equalTo(self.view.snp.trailing)
            header.height.equalTo(222)
        }
        
        emailField.snp.makeConstraints { nameField in
            nameField.top.equalTo(headerView.snp.bottom).offset(12)
            nameField.centerX.equalTo(headerView.snp.centerX)
            nameField.height.equalTo(55)
            nameField.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        passwordField.snp.makeConstraints { passField in
            passField.top.equalTo(emailField.snp.bottom).offset(22)
            passField.centerX.equalTo(headerView.snp.centerX)
            passField.height.equalTo(55)
            passField.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        signInButton.snp.makeConstraints { siginButt in
            siginButt.top.equalTo(passwordField.snp.bottom).offset(22)
            siginButt.centerX.equalTo(headerView.snp.centerX)
            siginButt.height.equalTo(55)
            siginButt.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        newUserButton.snp.makeConstraints { userButt in
            userButt.top.equalTo(signInButton.snp.bottom).offset(11)
            userButt.centerX.equalTo(headerView.snp.centerX)
            userButt.height.equalTo(44)
            userButt.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        forgotPasswordButton.snp.makeConstraints { forgotButton in
            forgotButton.top.equalTo(newUserButton.snp.bottom).offset(6)
            forgotButton.centerX.equalTo(headerView.snp.centerX)
            forgotButton.height.equalTo(44)
            forgotButton.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
    }
   //MARK: - Selectors
    @objc private func didTapSignIn() {
       let vc = HomeController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapNewUser() {
       let vc = RegisterController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapForgotPassword() {
        let vc = ForgotPasswordController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
