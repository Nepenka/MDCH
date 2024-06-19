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
import FirebaseStorage
import AVFoundation

class EditUsersSettingsController: UIViewController, UITextFieldDelegate {
    
    let nameUserSettingField = CustomTextField(authFieldType: .username)
    let editAvatrButton = CustomButton(title: "Edit Photo", hasBackground: false ,fontSize: .small)
    var avatarImage = UIImageView(image: UIImage(named: "default_image"))
    let clearButton = UIButton(type: .custom)
    let clearImage = UIImage(systemName: "multiply.circle.fill")
    let doneButton = CustomButton(title: "Done", hasBackground: false ,fontSize: .small)
    let cancelButton = CustomButton(title: "Cancel", hasBackground: false ,fontSize: .small)
    var onSave: ((String) -> Void)?
    var onUpdateAvatar: ((UIImage) -> Void)?
    let tableView = UITableView()
    let exitButton = CustomButton(title: "Exit",hasBackground: true ,fontSize: .big)
    var username = ""
    var email = ""
    var id = ""
    let imagePicker = UIImagePickerController()
    
    
    private lazy var settingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.showsVerticalScrollIndicator = false
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
        setupUI()
        clearButton.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonAction), for: .touchUpInside)
        editAvatrButton.addTarget(self, action: #selector(editAvatrButtonAction), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EditUsersSettingsControllerCell.self, forCellReuseIdentifier: "cell")
        nameUserSettingField.delegate = self
        loadInfoFromFirebase()
        imagePicker.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateClearButtonVisibility()
        loadInfoFromFirebase()
        
    }
    
    @objc func textFieldDidChangeSelection(_ textField: UITextField) {
        updateClearButtonVisibility()
        
    }
    
    private func updateClearButtonVisibility() {
        clearButton.isHidden = nameUserSettingField.text?.isEmpty ?? true
    }
    
    private func loadInfoFromFirebase() {
        let userCollectionRef = Firestore.firestore().collection("users")
        
        if let currentUserUID = Auth.auth().currentUser?.uid {
            userCollectionRef.document(currentUserUID).getDocument { [weak self] (document, error) in
                if let document = document, document.exists {
                    if let username = document.data()?["username"] as? String {
                        self?.username = username
                    }
                    if let email = document.data()?["email"] as? String {
                        self?.email = email
                    }
                    if let id = document.data()?["uniqueIdentifier"] as? String {
                        self?.id = id
                    }
                    if let avatarURL = document.data()?["avatarURL"] as? String, !avatarURL.isEmpty {
                        URLSession.shared.dataTask(with: (URL(string: avatarURL)!)) { [weak self] (data, response, error) in
                            if let error = error {
                                print(error.localizedDescription)
                                return
                            }
                            
                            guard let data = data, let image = UIImage(data: data) else {
                                print("Ошибка при конвертации данных в изображение")
                                return
                            }
                            
                            DispatchQueue.main.async {
                                self?.avatarImage.image = image
                                self?.onUpdateAvatar?(image)
                            }
                        }.resume()
                    } else {
                        DispatchQueue.main.async {
                            self?.avatarImage.image = UIImage(named: "default_image")
                        }
                    }
                    DispatchQueue.main.async {
                        if let text = self?.nameUserSettingField.text, text.isEmpty {
                            self?.nameUserSettingField.text = self?.username
                        }
                        self?.tableView.reloadData()
                    }
                } else {
                    print("Документ не найден")
                }
            }
        }
    }

    
    func uploadImageToFirebase(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Ошибка при конвертации")
            return
        }
        let storageRef = Storage.storage().reference().child("avatars").child("\(UUID().uuidString).jpg")
        storageRef.putData(imageData, metadata: nil) { [weak self] (metadata, error) in
            guard let _ = metadata else {
                print("Ошибка загрузки: \(error?.localizedDescription ?? "Error")")
                return
            }
            storageRef.downloadURL { [weak self] (url, error) in
                guard let downloadURL = url else {
                    print("Ошибка при получении URL загруженного изображения: \(error?.localizedDescription ?? "Error")")
                    return
                }
                self?.saveImageURLToFirestore(imageURL: downloadURL.absoluteString)
            }
        }
    }

    
    func saveImageURLToFirestore(imageURL: String) {
        if let currentUserUID = Auth.auth().currentUser?.uid {
            let userRef = Firestore.firestore().collection("users").document(currentUserUID)
            userRef.updateData(["avatarURL": imageURL]) { [weak self] error in
                if let error = error {
                    print("Ошибка при обновлении информации о пользователе: \(error.localizedDescription)")
                } else {
                    print("Изображение успешно загружено и сохранено")
                    self?.loadInfoFromFirebase()
                    if let url = URL(string: imageURL) {
                        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                            if let error = error {
                                print("Ошибка при загрузке изображения: \(error.localizedDescription)")
                                return
                            }
                            
                            guard let data = data, let image = UIImage(data: data) else {
                                print("Невозможно преобразовать данные в изображение")
                                return
                            }
                            
                            DispatchQueue.main.async {
                                self?.avatarImage.image = image
                            }
                        }.resume()
                    }
                }
            }
        }
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
        contentView.addSubview(tableView)
        contentView.addSubview(exitButton)
        
        
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
            nameField.left.right.equalToSuperview().inset(25)
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
        
        tableView.snp.makeConstraints { table in
            table.top.equalTo(nameUserSettingField.snp.bottom).offset(85)
            table.left.right.equalToSuperview()
            table.bottom.equalTo(exitButton.snp.top).offset(-20)
        }
        
        exitButton.snp.makeConstraints { exit in
            exit.bottom.equalTo(contentView.snp.bottom).inset(20)
            exit.left.right.equalToSuperview().inset(35)
            exit.height.equalTo(55)
        }

        
        exitButton.layer.borderColor = UIColor.red.cgColor
        exitButton.layer.borderWidth = 1.0
        
        
        
    }
    
    @objc func clearButtonAction()  {
        nameUserSettingField.text = ""
    }
    
    @objc func doneButtonAction() {
        if let enteredText = nameUserSettingField.text, !enteredText.isEmpty {
            let newName = enteredText
            SaveInfo.shared.saveNewUserName(newName: newName)
            onSave?(newName)
            
            
            if let currentUserUID = Auth.auth().currentUser?.uid {
                let userRef = Firestore.firestore().collection("users").document(currentUserUID)
                userRef.updateData(["username": newName]) { error in
                    if let error = error {
                        print("Ошибка при обновлении имени пользователя: \(error.localizedDescription)")
                    } else {
                        print("Имя пользователя успешно обновлено")
                    }
                }
            }
        } else {
            nameUserSettingField.text = username
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func exitButtonAction() {
        let loginVc = LoginController()
        loginVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(loginVc, animated: true)
        
    }
    
    @objc func editAvatrButtonAction() {
        let alert = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera is not available")
            return
        }
        
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            guard granted else {
                print("Camera access denied")
                return
            }
            
            DispatchQueue.main.async {
                self?.imagePicker.sourceType = .camera
                self?.present(self!.imagePicker, animated: true, completion: nil)
            }
        }
    }

    func openGallery() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}


extension EditUsersSettingsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EditUsersSettingsControllerCell else {return UITableViewCell() }
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Username: \(username)"
        }else if indexPath.row == 1 {
            cell.textLabel?.text = "Email: \(email)"
        }else if indexPath.row == 2 {
            cell.textLabel?.text = "ID: \(id)"
        }
        
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 12)
       
        
        cell.layer.borderWidth = 0.5
        
        return cell
    }
}

extension EditUsersSettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            avatarImage.image = pickedImage
            uploadImageToFirebase(image: pickedImage)
        }
        dismiss(animated: true, completion: nil)
    }
}
