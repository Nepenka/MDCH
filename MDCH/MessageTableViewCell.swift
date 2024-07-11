//
//  TableViewCell.swift
//  MDCH
//
//  Created by 123 on 23.03.24.
//

import FirebaseFirestore
import UIKit
import SnapKit
import Firebase




class MessageTableViewCell: UITableViewCell {
    
    weak var delegate: MessageTableViewCell?
    
    let nameLabel: UILabel = {
       let userLabel = UILabel()
        userLabel.font = UIFont(name: "Helvetica-Bold", size: 12)
        userLabel.textColor = .black
        userLabel.text = "Lll"
        return userLabel
    }()
    
    
    
    let avatarImage: UIImageView = {
       let avatar = UIImageView(image: UIImage(named: "default_image"))
        avatar.layer.cornerRadius = 25
        avatar.clipsToBounds = true
        return avatar
    }()
     
    
    let indCountLabel: UILabel = {
       let countLabel = UILabel()
        countLabel.text = "0"
        countLabel.textColor = .white
        countLabel.backgroundColor = .gray
        countLabel.font = UIFont(name: "Helvetica-Bold", size: 14)
        countLabel.layer.masksToBounds = true
        countLabel.textAlignment = .center
        return countLabel
    }()
    
    let timePostLabel: UILabel = {
       let timePost = UILabel()
        timePost.text = "22:20"
        timePost.font = UIFont(name: "Helvetica-Bold", size: 12)
        timePost.textColor = .gray
        
        return timePost
    }()
    
    
    let messageLabel: UILabel = {
       let message = UILabel()
        message.textColor = UIColor.darkGray
        message.text = "Хуй"
        message.font = UIFont(name: "Helvetica-Bold", size: 10)
        return message
    }()
    
    var indCount: Int = 0
    
    
    
    
    
    
    
    func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(avatarImage)
        contentView.addSubview(indCountLabel)
        contentView.addSubview(timePostLabel)
        contentView.addSubview(messageLabel)
        
        
        nameLabel.snp.makeConstraints { name in
            name.left.equalTo(avatarImage.snp.right).offset(10)
            name.top.equalToSuperview().offset(8)
        }
        
        avatarImage.snp.makeConstraints { avatar in
            avatar.left.equalToSuperview().offset(10)
            avatar.top.equalToSuperview().offset(10)
            avatar.width.height.equalTo(50) 
        }
        
        messageLabel.snp.makeConstraints { message in
            message.left.equalTo(avatarImage.snp.right).offset(10)
            message.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        
        timePostLabel.snp.makeConstraints { time in
            time.right.equalToSuperview().offset(-15)
            time.top.equalTo(messageLabel.snp.bottom).offset(5)
        }
        
        indCountLabel.snp.makeConstraints { int in
            int.right.equalToSuperview().offset(-20)
            int.bottom.equalTo(timePostLabel.snp.top).offset(-9)
            int.width.height.equalTo(20)
        }
        
        contentView.layoutIfNeeded()
        indCountLabel.layer.cornerRadius = indCountLabel.frame.size.height / 2
        
        
        
    }
    
    
    func configure(with message: Message) {
        FirebaseHelper.readUserNameFromFirebase(userId: message.userId, userNameLabel: nameLabel, avatarImageView: avatarImage)
        
        if let avatarURL = message.avatar?.absoluteString {
            FirebaseHelper.loadAvatarImage(from: avatarURL, into: avatarImage)
        } else {
            avatarImage.image = UIImage(named: "default_image")
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timePostLabel.text = formatter.string(from: message.timeMessage.dateValue())
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
        
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
}
