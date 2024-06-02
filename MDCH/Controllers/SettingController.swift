//
//  SettingViewController.swift
//  MDCH
//
//  Created by 123 on 24.03.24.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore


class SettingController: UIViewController {
    
    let editButton = CustomButton(title: "Edit", hasBackground: false, fontSize: .small)
    let nameLabel = CustomLabel(text: "default_name" , textColor: .black, fontSize: .big, fontStyle: .bold)
    let avatarImage = UIImageView(image: UIImage(named: "default_image"))
    
    
    private lazy var settingScrollView: UIScrollView = {
     let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView =  {
       let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 400)
    }
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white 
        setupUI()
        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        settingScrollView.showsVerticalScrollIndicator = false
        readUserNameFromFirebase()
        setupNavigationTitle(title: "Setting", withSearch: false)
    }
    
    
     func readUserNameFromFirebase() {
        let userCollectionRef = Firestore.firestore().collection("users")
        
        if let currentUserUID = Auth.auth().currentUser?.uid {
            userCollectionRef.document(currentUserUID).getDocument { (document, error)in
                if let document = document, document.exists {
                    if let username = document.data()?["username"] as? String {
                        self.nameLabel.text = username
                    }
                    
                } else {
                    print("Документ не найден")
                }
            }
        }
    }
   
    
    private func setupUI() {
        view.addSubview(settingScrollView)
        settingScrollView.addSubview(contentView)
        contentView.addSubview(editButton)
        contentView.addSubview(avatarImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(tableView)
        
        editButton.snp.makeConstraints { edit in
            edit.top.equalTo(contentView.snp.top).offset(10)
            edit.right.equalToSuperview().offset(-50)
        }
        
        avatarImage.snp.makeConstraints { avatar in
            avatar.centerX.equalToSuperview()
            avatar.width.height.equalTo(120)
            avatar.top.equalTo(editButton.snp.bottom).offset(10)
        }

        avatarImage.layer.cornerRadius = 50
        avatarImage.clipsToBounds = true
        
        nameLabel.snp.makeConstraints { name in
            name.top.equalTo(avatarImage.snp.bottom).offset(35)
            name.centerX.equalToSuperview()
        }
        
    }

    
    @objc func editButtonAction() {
        let vc = EditUsersSettingsController()
        vc.onSave = { [weak self] newName in
                self?.nameLabel.text = newName
            }
        
        vc.onUpdateAvatar = { [weak self] newImage in
                self?.avatarImage.image = newImage
            }
        navigationController?.pushViewController(vc, animated: true)
    }
}


