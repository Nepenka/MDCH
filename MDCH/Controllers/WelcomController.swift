//
//  ViewController.swift
//  MDCH
//
//  Created by 123 on 6.02.24.
//

import UIKit
import SnapKit

class WelcomController: UIViewController {
    
    let welcomeLabel = UILabel()
    let startButton = CustomButton(title: "LET'S GOOOO!!!", hasBackground: false, fontSize: .big)
    let logoImageView = UIImageView()
    let infoLabel = UILabel()
    
    private let termsTextView: UITextView = {
        let attributedString = NSMutableAttributedString(string:  "By creating an account,you agree to our Terms & Conditions and you knowledge that you have read our Privacy Policy.")
        
        attributedString.addAttribute(.link, value: "terms://ttermsAndCondotions", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        attributedString.addAttribute(.link, value: "privacy://privacyPolicy", range:  (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemBlue.cgColor]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = .label
        tv.isEditable = true
        tv.isSelectable = true
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        return tv
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.view.backgroundColor = .white
        self.termsTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    private func setupUI() {
        self.view.addSubview(termsTextView)
        self.view.addSubview(startButton)
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(logoImageView)
        self.view.addSubview(infoLabel)
        
        
        
        welcomeLabel.text = "Press the button and we'll go on a journey"
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        welcomeLabel.numberOfLines = 2
        
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "logo")
        logoImageView.tintColor = .white
        
        infoLabel.text = "Messenger in which you can be anyone"
        infoLabel.textColor = .gray
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont(name: "Helvetica-Bold", size: 15)
        infoLabel.numberOfLines = 2
        
        welcomeLabel.snp.makeConstraints { welcome in
            welcome.centerY.equalToSuperview().inset(-90)
            welcome.right.left.equalToSuperview().inset(45)
        }
        
        infoLabel.snp.makeConstraints { info in
            info.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            info.right.left.equalToSuperview().inset(50)
        }
        
        startButton.snp.makeConstraints { button in
            button.top.equalTo(welcomeLabel.snp.bottom).offset(90)
            button.right.left.equalToSuperview().inset(60)
        }
        
        termsTextView.snp.makeConstraints { view in
            view.top.equalTo(startButton.snp.bottom).offset(140)
            view.right.left.equalToSuperview().inset(50)
        }
        
        logoImageView.snp.makeConstraints { logo in
            logo.bottom.equalTo(welcomeLabel.snp.top).offset(-40)
            logo.right.left.equalToSuperview().inset(50)
            logo.height.equalTo(120)
        }
        
        
        
    }
    


}

extension WelcomController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "terms" {
            self.showWebViewerController(with: "https://policies.google.com/terms?hl=en-US")
        } else if URL.scheme == "privacy" {
            self.showWebViewerController(with: "https://policies.google.com/privacy?hl=en-US")
        }
        
        
        return true
    }
    
    private func showWebViewerController(with urlString: String) {
        let vc = WebViewController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.delegate = nil
        textView.selectedTextRange = nil
        textView.delegate = self
    }
    
}
