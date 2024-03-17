//
//  RegisterController.swift
//  MDCH
//
//  Created by 123 on 17.02.24.
//

import UIKit
import SnapKit


class RegisterController: UIViewController {
    
    //MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign Up", subTitle: "Create your account")
    private let emailField = CustomTextField(authFieldType: .email)
    private let usernameField = CustomTextField(authFieldType: .username)
    private let passwordField = CustomTextField(authFieldType: .password)
    private let signInButton = CustomButton(title: "Already have an account? Sign In.", hasBackground: false, fontSize: .small)
    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    private let termsTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string: "By creating an account,you agree to our Terms & Conditions and you knowledge that you have read our Privacy Policy.")
        attributedString.addAttribute(.link, value: "terms://termsAndConditions", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.delaysContentTouches = false
        tv.textColor = .label
        tv.isSelectable = true
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setupUI()
        self.termsTextView.delegate = self
        
        signInButton.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        self.view.addSubview(headerView)
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(emailField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(signInButton)
        self.view.addSubview(termsTextView)
       
        
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
        
        emailField.snp.makeConstraints { email in
            email.top.equalTo(usernameField.snp.bottom).offset(22)
            email.centerX.equalTo(headerView.snp.centerX)
            email.height.equalTo(55)
            email.width.equalToSuperview().multipliedBy(0.85)
        }
        
        passwordField.snp.makeConstraints { password in
            password.top.equalTo(emailField.snp.bottom).offset(22)
            password.centerX.equalTo(headerView.snp.centerX)
            password.height.equalTo(55)
            password.width.equalToSuperview().multipliedBy(0.85)
        }
        
        signUpButton.snp.makeConstraints { upButton in
            upButton.top.equalTo(emailField.snp.bottom).offset(22)
            upButton.centerX.equalTo(headerView.snp.centerX)
            upButton.height.equalTo(55)
            upButton.width.equalToSuperview().multipliedBy(0.85)
        }
        
        termsTextView.snp.makeConstraints { termsView in
            termsView.top.equalTo(signUpButton.snp.bottom).offset(6)
            termsView.centerX.equalTo(headerView.snp.centerX)
            termsView.width.equalToSuperview().multipliedBy(0.85)
        }
        
        
        
        signInButton.snp.makeConstraints { button in
            button.top.equalTo(termsTextView.snp.bottom).offset(11)
            button.centerX.equalTo(headerView.snp.centerX)
            button.height.equalTo(44)
            button.width.equalToSuperview().multipliedBy(0.85)
        }
        
        
        
        
        
    }
    
    //MARK: - Selectors
    
    @objc func signUpAction() {
        let webViewer = WebViewerController(with: "")
        let nav = UINavigationController(rootViewController: webViewer)
        self.present(nav, animated: true)
    }
    
    @objc func signInButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension RegisterController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "terms" {
            self.showWebViwerController(with: "https://policies.google.com/terms?hl=en-US")
        }else if URL.scheme == "privacy" {
            self.showWebViwerController(with: "https://policies.google.com/privacy?hl=en-US")
        }
        return true
    }
    
    private func showWebViwerController(with urlString: String) {
        let vc = WebViewerController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true)
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
    
}
