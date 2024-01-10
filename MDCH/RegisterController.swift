//
//  RegisterController.swift
//  MDCH
//
//  Created by 123 on 10.01.24.
//

import UIKit

class RegisterController: UIViewController {
    //MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign Up", subtitle: "Create you account")
    
    private let usernameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    private let signUpButton = CustomButton(title: "Sign Up",hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "Already have an account? Sign In.", fontSize: .medium)
    
    private let termTextView: UITextView = {
       let tv = UITextView()
        tv.text = "By creating an account,you agree to our Terms & Conditions and you knowledge that you have read our Privacy Policy."
        tv.backgroundColor = .clear
        tv.textColor = .label
        tv.isSelectable = true
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
                                                
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }

    //MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        self.view.addSubview(usernameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(termTextView)
        self.view.addSubview(signInButton)
       
        
        headerView.snp.makeConstraints { header in
            header.top.equalTo(self.view.layoutMarginsGuide.snp.top)
            header.leading.equalTo(self.view.snp.leading)
            header.trailing.equalTo(self.view.snp.trailing)
            header.height.equalTo(222)
        }
        
        usernameField.snp.makeConstraints { nameField in
            nameField.top.equalTo(headerView.snp.bottom).offset(12)
            nameField.centerX.equalTo(headerView.snp.centerX)
            nameField.height.equalTo(55)
            nameField.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        emailField.snp.makeConstraints { mailField in
            mailField.top.equalTo(usernameField.snp.bottom).offset(22)
            mailField.centerX.equalTo(headerView.snp.centerX)
            mailField.height.equalTo(55)
            mailField.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        passwordField.snp.makeConstraints { passField in
            passField.top.equalTo(emailField.snp.bottom).offset(22)
            passField.centerX.equalTo(headerView.snp.centerX)
            passField.height.equalTo(55)
            passField.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        signUpButton.snp.makeConstraints { signButt in
            signButt.top.equalTo(passwordField.snp.bottom).offset(22)
            signButt.centerX.equalTo(headerView.snp.centerX)
            signButt.height.equalTo(55)
            signButt.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        termTextView.snp.makeConstraints { termView in
            termView.top.equalTo(signUpButton.snp.bottom).offset(6)
            termView.centerX.equalTo(headerView.snp.centerX)
            termView.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        signInButton.snp.makeConstraints { siginButt in
            siginButt.top.equalTo(termTextView.snp.bottom).offset(11)
            siginButt.centerX.equalTo(headerView.snp.centerX)
            siginButt.height.equalTo(44)
            siginButt.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        
       
    }
   //MARK: - Selectors
    
    @objc private func didTapSignUp() {
        print("DEBUG PRINT:", "didTapSignUp")
        let webViewer = WebViewrController(with: "")
        
        let nav = UINavigationController(rootViewController: webViewer)
        self.present(nav, animated: true)
    }
    
    @objc private func didTapSignIn() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
