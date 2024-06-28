//
//  ForgotPasswordController.swift
//  MDCH
//
//  Created by 123 on 17.02.24.
//



import UIKit
import SnapKit

class ForgotPasswordController: UIViewController {

    private let headerView = AuthHeaderView(title: "Forgot Password?", subTitle: "Reset your password")
    private let emailField = CustomTextField(authFieldType: .email)
    private let resetPassword = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupUI()
        self.resetPassword.addTarget(self, action: #selector(resetPasswordAction), for: .touchUpInside)
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    private func setupUI() {
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(resetPassword)

        headerView.snp.makeConstraints { header in
            header.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            header.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            header.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            header.height.equalTo(200) // Измените на подходящее значение
        }

        emailField.snp.makeConstraints { email in
            email.top.equalTo(headerView.snp.bottom).offset(20)
            email.centerX.equalTo(view.snp.centerX)
            email.height.equalTo(55)
            email.width.equalToSuperview().multipliedBy(0.85)
        }

        resetPassword.snp.makeConstraints { reset in
            reset.top.equalTo(emailField.snp.bottom).offset(22)
            reset.centerX.equalTo(view.snp.centerX)
            reset.height.equalTo(55)
            reset.width.equalToSuperview().multipliedBy(0.85)
        }
    }

    @objc func resetPasswordAction() {
        let email = self.emailField.text ?? ""

        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }

        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }

            AlertManager.showPasswordResetSend(on: self)
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
