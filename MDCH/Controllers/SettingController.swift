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
    let tableView = UITableView()

    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white 
        setupUI()
        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        settingScrollView.showsVerticalScrollIndicator = false
        readUserNameFromFirebase()
        setupNavigationTitle(title: "Setting", withSearch: false)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingControllerTableViewCell.self, forCellReuseIdentifier: "cell")
        AuthService.shared.addUniqueIdentifierToExistingUsers()
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
        
        
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.layer.borderWidth = 1.0
        
        tableView.snp.makeConstraints { table in
                    table.top.equalTo(nameLabel.snp.bottom).offset(55)
                    table.left.right.equalToSuperview()
                    table.bottom.equalTo(contentView.snp.bottom)
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


extension SettingController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SettingControllerTableViewCell else {return UITableViewCell()}
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Change Password"
            cell.textLabel?.textColor = .black
            cell.textLabel?.font = UIFont(name: "Helevetica-Bold", size: 14)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChangePasswordController()
        
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
