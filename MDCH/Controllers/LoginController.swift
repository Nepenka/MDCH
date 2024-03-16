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
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private let newUserButton = CustomButton(title: "New User? Create Account.", hasBackground: false, fontSize: .medium)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password", fontSize: .small)
    
    //MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupUI()
        
        signInButton.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotButtonAction), for: .touchUpInside)
        newUserButton.addTarget(self, action: #selector(userButtonAction), for: .touchUpInside)
        
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(headerView)
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        self.view.addSubview(newUserButton)
        self.view.addSubview(forgotPasswordButton)
        
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
        
        signInButton.snp.makeConstraints { button in
            button.top.equalTo(passwordField.snp.bottom).offset(25)
            button.centerX.equalTo(headerView.snp.centerX)
            button.height.equalTo(55)
            button.width.equalToSuperview().multipliedBy(0.85)
        }
        
        newUserButton.snp.makeConstraints { user in
            user.top.equalTo(signInButton.snp.bottom).offset(11)
            user.height.equalTo(44)
            user.centerX.equalTo(headerView.snp.centerX)
            user.width.equalToSuperview().multipliedBy(0.85)
        }
        
        forgotPasswordButton.snp.makeConstraints { forgot in
            forgot.top.equalTo(newUserButton.snp.bottom).offset(6)
            forgot.centerX.equalTo(headerView.snp.centerX)
            forgot.height.equalTo(44)
            forgot.width.equalToSuperview().multipliedBy(0.85)
        }
        
        
        
        
        
    }
    
    //MARK: - Selectors
    
    @objc func signInButtonAction() {
        let vc = HomeController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func forgotButtonAction() {
        let vc = ForgotPasswordController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func userButtonAction() {
        let vc = RegisterController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
