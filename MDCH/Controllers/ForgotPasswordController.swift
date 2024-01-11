//
//  ForgotPasswordController.swift
//  MDCH
//
//  Created by 123 on 10.01.24.
//

import UIKit
import SnapKit



class ForgotPasswordController: UIViewController {
    
    
    //MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Forgot password", subtitle: "Reset your password")
    private let emailField = CustomTextField(fieldType: .email)
    private let resetPasswordButton = CustomButton(title: "Sign Up",hasBackground: true ,fontSize: .big)
    
    
    
    //MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.resetPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    //MARK: - UI Step
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(resetPasswordButton)
        
        headerView.snp.makeConstraints { header in
            header.top.equalTo(self.view.snp.top).offset(30)
            header.leading.equalTo(self.view.snp.leading)
            header.trailing.equalTo(self.view.snp.trailing)
            header.height.equalTo(230)
        }
        
        emailField.snp.makeConstraints { mailField in
            mailField.top.equalTo(headerView.snp.bottom).offset(11)
            mailField.centerX.equalTo(headerView.snp.centerX)
            mailField.height.equalTo(55)
            mailField.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        resetPasswordButton.snp.makeConstraints { resetButton in
            resetButton.top.equalTo(emailField.snp.bottom).offset(22)
            resetButton.centerX.equalTo(headerView.snp.centerX)
            resetButton.height.equalTo(55)
            resetButton.width.equalTo(self.view.snp.width).multipliedBy(0.85)
        }
        
        
    }
    
    
    
    //MARK: - Selectors
    @objc private func didTapForgotPassword() {
        guard let email = self.emailField.text, !email.isEmpty else { return }
        
        // TODO: - Email validation
        
        
    }
    
}
