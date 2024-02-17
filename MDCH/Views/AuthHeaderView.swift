//
//  AuthHeaderView.swift
//  MDCH
//
//  Created by 123 on 17.02.24.
//

import UIKit
import SnapKit



class AuthHeaderView: UIView {
    
    //MARK: - UI Components
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "logo")
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
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Title"
        return label
    }()
    
    //MARK: - LifeCycle
    init(title: String, subTitle: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI Setup
    
   private func setupUI() {
    
       self.addSubview(imageView)
       self.addSubview(titleLabel)
       self.addSubview(subTitleLabel)
       
       imageView.snp.makeConstraints { image in
           
           image.top.equalTo(layoutMarginsGuide.snp.top).offset(16)
           image.centerX.equalToSuperview()
           image.width.equalTo(90)
           image.height.equalTo(imageView.snp.width)
           
           
       }
       
       titleLabel.snp.makeConstraints { title in
           title.top.equalTo(imageView.snp.bottom).offset(19)
           title.leading.equalToSuperview()
           title.trailing.equalToSuperview()
           
       }
       
       subTitleLabel.snp.makeConstraints { subTitle in
           subTitle.top.equalTo(titleLabel.snp.bottom).offset(19)
           subTitle.leading.equalToSuperview()
           subTitle.trailing.equalToSuperview()
       }
       
    }
    
    
}
