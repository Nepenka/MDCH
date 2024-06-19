//
//  ChangePasswordController.swift
//  MDCH
//
//  Created by 123 on 18.06.24.
//

import UIKit
import SnapKit
import FirebaseAuth

class ChangePasswordController: UIViewController {
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    private let currentPasswordField = CustomTextField(authFieldType: .password)
    private let newPasswordField = CustomTextField(authFieldType: .password)
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
        view.addSubview(currentPasswordField)
        view.addSubview(newPasswordField)
        view.addSubview(nextButton)
        
        headerView.snp.makeConstraints { header in
            header.top.equalTo(view.snp.top).offset(50)
            header.leading.equalTo(view.snp.leading)
            header.trailing.equalTo(view.snp.trailing)
            header.height.equalTo(270)
        }
        
        currentPasswordField.placeholder = "Current Password"
        currentPasswordField.snp.makeConstraints { password in
            password.top.equalTo(headerView.snp.bottom).offset(85)
            password.left.equalToSuperview().offset(20)
            password.right.equalToSuperview().offset(-20)
            password.height.equalTo(55)
        }
        
        newPasswordField.placeholder = "New Password"
        newPasswordField.snp.makeConstraints { password in
            password.top.equalTo(currentPasswordField.snp.bottom).offset(25)
            password.left.equalToSuperview().offset(20)
            password.right.equalToSuperview().offset(-20)
            password.height.equalTo(55)
        }
        
        nextButton.snp.makeConstraints { button in
            button.top.equalTo(newPasswordField.snp.bottom).offset(25)
            button.centerX.equalTo(headerView.snp.centerX)
            button.height.equalTo(55)
            button.width.equalToSuperview().multipliedBy(0.85)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func nextButtonAction() {
        guard let currentPassword = currentPasswordField.text, !currentPassword.isEmpty,
              let newPassword = newPasswordField.text, !newPassword.isEmpty else {
            showAlert(message: "Please fill in both fields")
            return
        }
        
        reauthenticateUser(currentPassword: currentPassword, newPassword: newPassword)
    }
    
    func reauthenticateUser(currentPassword: String, newPassword: String) {
        guard let user = Auth.auth().currentUser,
              let email = user.email else {
            showAlert(message: "User not found")
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        user.reauthenticate(with: credential) { [weak self] authResult, error in
            if let error = error {
                print("Reauthentication failed: \(error.localizedDescription)")
                self?.showAlert(message: "Reauthentication failed: \(error.localizedDescription)")
            } else {
                self?.updatePassword(newPassword: newPassword)
            }
        }
    }
    
    func updatePassword(newPassword: String) {
        let user = Auth.auth().currentUser
        user?.updatePassword(to: newPassword) { [weak self] error in
            if let error = error {
                print("Error updating password: \(error.localizedDescription)")
                self?.showAlert(message: "Failed to update password: \(error.localizedDescription)")
            } else {
                print("Password updated successfully")
                self?.showAlert(message: "Password updated successfully", completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
}

