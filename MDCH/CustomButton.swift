//
//  CustomButton.swift
//  MDCH
//
//  Created by 123 on 6.02.24.
//

import UIKit


class CustomButton: UIButton {
    
    enum FontSize {
        case big
        case medium
        case small
    }
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        
        self.backgroundColor = hasBackground ? .systemBlue : .clear
        
        let titleColor: UIColor = hasBackground ? .black : .white
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontSize{
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22,weight: .bold)
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2.0
            self.layer.cornerRadius = 23
            self.backgroundColor = .systemBlue
        case .medium:
            self.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
