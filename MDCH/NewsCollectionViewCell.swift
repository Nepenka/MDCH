//
//  NewsTableViewCell.swift
//  MDCH
//
//  Created by 123 on 26.03.24.
//

import Foundation
import UIKit
import SnapKit
import Firebase
import FirebaseFirestore


class NewsCollectionViewCell: UICollectionViewCell {
    
    let userName: UILabel = {
        let username = UILabel()
        username.text = ""
        username.font = UIFont(name: "Helvetica-Bold", size: 15)
        username.textColor = UIColor.black
        
        return username
    }()
    
    let avatar: UIImageView = {
       var avatarImage = UIImageView(image: UIImage(named: "default_image"))
        avatarImage.layer.cornerRadius = 25
        avatarImage.clipsToBounds = true
        
        return avatarImage
    }()
    
    func setupViews() {
        contentView.addSubview(userName)
        contentView.addSubview(avatar)
        
        userName.snp.makeConstraints { user in
            user.left.equalTo(avatar.snp.right).offset(10)
            user.centerY.equalTo(avatar.snp.centerY)
        }
        
        avatar.snp.makeConstraints { image in
            image.left.equalToSuperview().offset(30)
            image.top.equalToSuperview().offset(45)
            image.height.width.equalTo(50)
        }
    }
    
    
    func readUserNameFromFirebase() {
       let userCollectionRef = Firestore.firestore().collection("users")
       
       if let currentUserUID = Auth.auth().currentUser?.uid {
           userCollectionRef.document(currentUserUID).getDocument { (document, error)in
               if let document = document, document.exists {
                   if let username = document.data()?["username"] as? String {
                       self.userName.text = username
                   }
               } else {
                   print("Документ не найден")
               }
           }
       }
   }
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
}
