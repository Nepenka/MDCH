//
//  EditUsersSettingsController.swift
//  MDCH
//
//  Created by 123 on 25.03.24.
//

import UIKit
import SnapKit
import Firebase
import FirebaseFirestore

class EditUsersSettingsController: UIViewController {
    
    let nameUserSettingField = CustomTextField(authFieldType: .username)
    let editAvatrButton = CustomButton(title: "Edit Photo", hasBackground: false ,fontSize: .small)
    let avatarImage = UIImageView(image: UIImage(named: "default_image"))
    let clearButton = UIButton(type: .custom)
    let clearImage = UIImage(systemName: "multiply.circle.fill")
    let doneButton = CustomButton(title: "Done", hasBackground: false ,fontSize: .small)
    let cancelButton = CustomButton(title: "Cancel", hasBackground: false ,fontSize: .small)
    var onUsernameReceived: ((String) -> Void)?
    var onSave: ((String) -> Void)?
    
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
        navigationItem.hidesBackButton = true
        settingScrollView.showsVerticalScrollIndicator = false
        setupUI()
        clearButton.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(settingScrollView)
        settingScrollView.addSubview(contentView)
        contentView.addSubview(avatarImage)
        contentView.addSubview(editAvatrButton)
        contentView.addSubview(nameUserSettingField)
        contentView.addSubview(clearButton)
        contentView.addSubview(doneButton)
        contentView.addSubview(cancelButton)
        
        doneButton.snp.makeConstraints { done in
            done.right.equalTo(contentView.snp.right).offset(-15)
            done.top.equalTo(contentView.snp.top).offset(5)
        }
        
        avatarImage.snp.makeConstraints { avatar in
            avatar.centerX.equalToSuperview()
            avatar.width.height.equalTo(120)
            avatar.top.equalTo(doneButton.snp.bottom).offset(20)
        }

        avatarImage.layer.cornerRadius = 50
        avatarImage.clipsToBounds = true
        
        editAvatrButton.snp.makeConstraints { editButton in
            editButton.top.equalTo(avatarImage.snp.bottom).offset(15)
            editButton.centerX.equalToSuperview()
        }
        
        nameUserSettingField.snp.makeConstraints { nameField in
            nameField.top.equalTo(editAvatrButton.snp.bottom).offset(30)
            nameField.left.right.equalToSuperview().inset(40)
            nameField.height.equalTo(50)
        }
        
       
        clearButton.setImage(clearImage, for: .normal)
        clearButton.tintColor = .gray
        clearButton.snp.makeConstraints { clear in
            clear.trailing.equalTo(nameUserSettingField.snp.trailing).offset(-10)
            clear.centerY.equalTo(nameUserSettingField.snp.centerY)
            clear.width.height.equalTo(20)
        }
        
        cancelButton.snp.makeConstraints { cancel in
            cancel.left.equalTo(contentView.snp.left).offset(15)
            cancel.top.equalTo(contentView.snp.top).offset(5)
        }
        
        
    }
    
    @objc func clearButtonAction()  {
        nameUserSettingField.text = ""
    }
    
    @objc func doneButtonAction() {
        if let enteredText = nameUserSettingField.text, !enteredText.isEmpty {
            let newName = enteredText
            onSave?(newName)
        }
        let username = nameUserSettingField.text ?? ""
        onUsernameReceived?(username)
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func cancelButtonAction() {
        
        navigationController?.popViewController(animated: true)
    }
    
}
