//
//  AuthHeaderView.swift
//  MDCH
//
//  Created by 123 on 10.01.24.
//

import UIKit
import SnapKit


class AuthHeaderView: UIView {

    
    //MARK: - UI Components
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "logo")
        iv.tintColor = .white
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Error"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    //MARK: - LifeCycle
    init(title: String, subtitle: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.subTitleLabel.text = subtitle
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   //MARK: - UI Setup
    
    
    private func setupUI() {
        self.addSubview(logoImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        self.logoImageView.snp.makeConstraints { logo in
            logo.top.equalTo(self.snp.top).offset(30)
            logo.centerX.equalTo(self.snp.centerX)
            logo.width.equalTo(90)
            logo.height.equalTo(self.logoImageView.snp.width)
        }
        
        self.titleLabel.snp.makeConstraints { title in
            title.top.equalTo(self.logoImageView.snp.bottom).offset(19)
            title.leading.equalTo(self.snp.leading)
            title.trailing.equalTo(self.snp.trailing)
        }
        
        self.subTitleLabel.snp.makeConstraints { sub in
            sub.top.equalTo(titleLabel.snp.bottom).offset(12)
            sub.leading.equalTo(self.snp.leading)
            sub.trailing.equalTo(self.snp.trailing)
        }
        
    }
}
