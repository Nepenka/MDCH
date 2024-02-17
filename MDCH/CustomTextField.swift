//
//  CustomTextField.swift
//  MDCH
//
//  Created by 123 on 17.02.24.
//

import UIKit

class CustomTextField: UITextField {

    enum CustomTextFieldType {
        case username
        case password
        case email
    }
    
    private let authFieldType: CustomTextFieldType
    
    init(authFieldType: CustomTextFieldType) {
        self.authFieldType = authFieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch authFieldType {
        case .username: 
            self.placeholder = "Username"
            
        case .password:
            self.placeholder = "Password"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
            
        case .email:
            self.placeholder = "Email"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
