//
//  AlertManager.swift
//  MDCH
//
//  Created by 123 on 18.03.24.
//

import UIKit




class AlertManager {
    
    private static func showBasicAler(on vc: UIViewController, title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
}



//MARK: - Validation Alerts
extension AlertManager {
    public static func showInvalidEmailAlert(on vc: UIViewController) {
        self.showBasicAler(on: vc, title: "Invalid Email", message: "Please enter a valida email")
    }
    
    public static func showInvalidPasswordAlert(on vc: UIViewController) {
        self.showBasicAler(on: vc, title: "Invalid Password", message: "Please enter a valida password")
    }
    
    public static func showInvalidUsernameAlert(on vc: UIViewController) {
        self.showBasicAler(on: vc, title: "Invalid Username", message: "Please enter a valida username")
    }
}


//MARK: - Errors

extension AlertManager {
    public static func showRegistrationErrorAlert(on vc: UIViewController) {
        self.showBasicAler(on: vc, title: "Unknown Registatration Error", message: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAler(on: vc, title: "Unknown Registatration Error", message: "\(error.localizedDescription)")
    }
}


//MARK: - Login Errors

extension AlertManager {
    public static func showSignInErrorAlert(on vc: UIViewController) {
        self.showBasicAler(on: vc, title: "Unknown Error Signing In", message: nil)
    }
    
    public static func showSignInErrorAlert(on vc: UIViewController, with error: Error) {
        self.showBasicAler(on: vc, title: "Error Signing In", message: "\(error.localizedDescription)")
    }
}


//MARK: - Logout Errors

extension AlertManager {
    public static func showLogOutError(on vc: UIViewController, with error: Error) {
        self.showBasicAler(on: vc, title: "Log Out Error", message: "\(error.localizedDescription)")
    }
}

//MARK: - Forgot Password

extension AlertManager {
    
    public static func showPasswordResetSend(on vc: UIViewController) {
        self.showBasicAler(on: vc, title: "Password Reset Seent", message: nil)
    }
    
    public static func showErrorSendingPasswordReset(on vc: UIViewController, with error: Error) {
        self.showBasicAler(on: vc, title: "Error Sending Password Reset", message: "\(error.localizedDescription)")
    }
}

//MARK: - Fetching User Errors

extension AlertManager {
    public static func showFetchingUserError(on vc: UIViewController, with error: Error) {
        self.showBasicAler(on: vc, title: "Error Fetching User", message: "\(error.localizedDescription)")
    }
    
    public static func showUnknownFetchingUserError(on vc: UIViewController) {
        self.showBasicAler(on: vc, title: "Unknown Error Fetching User", message: nil)
    }
}
