//
//  CustomLabel.swift
//  MDCH
//
//  Created by 123 on 24.03.24.
//

import Foundation
import UIKit




class CustomLabel: UILabel {
    
    enum FontSize {
        case big
        case medium
        case small
    }
    
    enum FontStyle {
        case bold
        case semibold
        case regular
    }
    
    
    init(text: String, textColor: UIColor, fontSize: FontSize, fontStyle: FontStyle) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        
        switch fontSize {
        case .big:
            setFont(size: 22, style: fontStyle)
        case .medium:
            setFont(size: 18, style: fontStyle)
        case .small:
            setFont(size: 16, style: fontStyle)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setFont(size: CGFloat, style: FontStyle) {
        switch style {
        case .bold:
            self.font = .systemFont(ofSize: size, weight: .bold)
        case .regular:
            self.font = .systemFont(ofSize: size, weight: .regular)
        case .semibold:
            self.font = .systemFont(ofSize: size, weight: .semibold)
        }
    }
    
}
