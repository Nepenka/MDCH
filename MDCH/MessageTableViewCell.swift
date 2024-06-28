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
        userLabel.text = ""
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
        countLabel.textColor = .black
        return countLabel
    }()
    
    let timePostLabel: UILabel = {
       let timePost = UILabel()
        timePost.font = UIFont(name: "Helvetica-Bold", size: 12)
        timePost.textColor = .gray
        
        return timePost
    }()
    
    
    let messageLabel: UILabel = {
       let message = UILabel()
        message.textColor = UIColor.darkGray
        message.text = ""
        return message
    }()
    var indCount: Int = 0
    
    
    
    
    
    
    
    func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(avatarImage)
        contentView.addSubview(indCountLabel)
        contentView.addSubview(timePostLabel)
        contentView.addSubview(messageLabel)
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
        
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
}
