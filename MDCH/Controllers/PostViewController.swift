//
//  PostViewController.swift
//  MDCH
//
//  Created by 123 on 5.05.24.
//

import UIKit
import SnapKit
import FirebaseFirestore



class PostViewController: UIViewController {
    
    var postTextView = UITextView(frame: CGRect(x: 20, y: 100, width: 200, height: 150))
    var titleTextField = CustomTextField(authFieldType: .username)
    let themeLabel = CustomLabel(text: "Theme", textColor: .black, fontSize: .medium, fontStyle: .bold)
    let descriptionLabel = CustomLabel(text: "Description", textColor: .black, fontSize: .medium, fontStyle: .bold)
    let postButton = CustomButton(title: "Send", hasBackground: true, fontSize: .medium)
    let checkMarkButton = UIButton(type: .custom)
    let checkMarkImage = UIImage(systemName: "checkmark")
    let labelSymbol = UILabel()
    let countSymbol = 500
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    var isCheckMarkButton = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        checkMarkButton.addTarget(self, action: #selector(checkMarkAction), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(postAction), for: .touchUpInside)
        view.addGestureRecognizer(tapGesture)
        postTextView.delegate = self
    }
    
    
    func setupUI() {
        view.addSubview(postTextView)
        view.addSubview(titleTextField)
        view.addSubview(themeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(checkMarkButton)
        view.addSubview(postButton)
        view.addSubview(labelSymbol)
        
        
        
        themeLabel.snp.makeConstraints { theme in
            theme.top.equalToSuperview().offset(50)
            theme.left.right.equalToSuperview().offset(10)
        }
        
        
        
        titleTextField.placeholder = "Theme..."
        titleTextField.snp.makeConstraints { title in
            title.top.equalTo(themeLabel.snp.bottom).offset(20)
            title.left.equalToSuperview().offset(10)
            title.right.equalToSuperview().offset(-50)
            title.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints { description in
            description.top.equalTo(titleTextField.snp.bottom).offset(50)
            description.left.right.equalToSuperview().offset(10)
        }
        
        checkMarkButton.tintColor = .gray
        checkMarkButton.setImage(checkMarkImage, for: .normal)
        checkMarkButton.snp.makeConstraints { checkmark in
            checkmark.trailing.equalTo(titleTextField.snp.trailing).offset(-10)
            checkmark.centerY.equalTo(titleTextField.snp.centerY)
            checkmark.width.height.equalTo(20)
        }
        
        postTextView.textColor = .black
        postTextView.layer.borderColor = UIColor.black.cgColor
        postTextView.layer.cornerRadius = 10
        postTextView.layer.borderWidth = 2.0
        postTextView.isEditable = true
        postTextView.isScrollEnabled = true
        postTextView.backgroundColor = .white
        postTextView.font = UIFont.systemFont(ofSize: 16)
        
        postTextView.snp.makeConstraints { post in
            post.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            post.left.right.equalToSuperview().inset(10)
            post.height.equalTo(300)
        }
    
        
        
        postButton.snp.makeConstraints { button in
            button.top.equalTo(postTextView.snp.bottom).offset(45)
            button.right.equalToSuperview().offset(-35)
            button.left.equalToSuperview().inset(170)
            button.height.equalTo(50)
        }
        
        
        labelSymbol.text = "0/500"
        labelSymbol.font = UIFont(name: "Helvetica-Bold", size: 13)
        labelSymbol.textColor = .gray
        labelSymbol.textAlignment = .right
        labelSymbol.sizeToFit()
        labelSymbol.snp.makeConstraints { symbol in
            symbol.trailing.equalTo(postTextView.snp.trailing).offset(-20)
            symbol.bottom.equalTo(postTextView.snp.bottom).inset(-25)
            symbol.width.equalTo(45)
        }
        
    }
    
    @objc func checkMarkAction() {
        if let text = titleTextField.text, !text.isEmpty {
            isCheckMarkButton = true
            postTextView.becomeFirstResponder()
        } else {
            AlertManager.showThemeMistake(on: self)
        }
    }
    
    @objc func postAction() {
        if let descriptionText = postTextView.text, !descriptionText.isEmpty {
            
            if isCheckMarkButton {
                
                dismissKeyboard()
                
                
                let theme = titleTextField.text ?? ""
                let description = postTextView.text ?? ""
                
                let postId = UUID().uuidString 

                let postData: [String: Any] = [
                    "theme": theme,
                    "description": description,
                    "timestamp": Timestamp(date: Date())
                ]

                let db = Firestore.firestore()
                
                db.collection("posts").document(postId).setData(postData) { [weak self] error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Данные успешно сохранены!")
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                AlertManager.showButtonMistake(on: self)
            }
            
            }else {
            AlertManager.showDescriptionMistake(on: self)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension PostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let characterCount = textView.text.count
        labelSymbol.text = "\(characterCount)/\(countSymbol)"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let newText = textView.text as NSString? else {return true}
        let updateText = newText.replacingCharacters(in: range, with: text)
        
        return updateText.count < countSymbol
    }
}
