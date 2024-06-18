//
//  ChangePasswordController.swift
//  MDCH
//
//  Created by 123 on 18.06.24.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth



class ChangePasswordController: UIViewController {
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    private let passwordField = CustomTextField(authFieldType: .password)
    private let nextButton = CustomButton(title: "Next", hasBackground: true, fontSize: .medium)
    private let headerView = AuthHeaderView(title: "Change password?", subTitle: ":)")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupUI() {
        view.addSubview(headerView)
        view.addSubview(passwordField)
        view.addSubview(nextButton)
        
        headerView.snp.makeConstraints { header in
            header.top.equalTo(view.snp.top).offset(50)
            header.leading.equalTo(view.snp.leading)
            header.trailing.equalTo(view.snp.trailing)
            header.height.equalTo(270)
        }
        
        
        passwordField.snp.makeConstraints { password in
            password.top.equalTo(headerView.snp.bottom).offset(85)
            password.left.equalToSuperview().offset(20)
            password.right.equalToSuperview().offset(-20)
            password.height.equalTo(55)
        }
        
        nextButton.snp.makeConstraints { button in
            button.top.equalTo(passwordField.snp.bottom).offset(25)
            button.centerX.equalTo(headerView.snp.centerX)
            button.height.equalTo(55)
            button.width.equalToSuperview().multipliedBy(0.85)
            
        }
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func nextButtonAction() {
        
    }
    
    
}
