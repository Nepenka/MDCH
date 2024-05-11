//
//  PostViewController.swift
//  MDCH
//
//  Created by 123 on 5.05.24.
//

import UIKit
import SnapKit


//В сам textView добавить чтобы можно было вписать минимум 6 символов и максимум n символов. Так же добавить label на сам textView с максимальным количессвтом введёных символов.


class PostViewController: UIViewController {
    
    var postTextView = UITextView(frame: CGRect(x: 20, y: 100, width: 200, height: 150))
    var titleTextField = CustomTextField(authFieldType: .username)
    let themeLabel = CustomLabel(text: "Theme", textColor: .black, fontSize: .medium, fontStyle: .bold)
    let descriptionLabel = CustomLabel(text: "Description", textColor: .black, fontSize: .medium, fontStyle: .bold)
    let postButton = CustomButton(title: "Send", hasBackground: true, fontSize: .medium)
    let checkMarkButton = UIButton(type: .custom)
    let checkMarkImage = UIImage(systemName: "checkmark")
    let arrowTriangle = UIImage(systemName: "arrowtriangle.forward.fill")
    let countSymbol = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        checkMarkButton.addTarget(self, action: #selector(checkMarkAction), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(postAction), for: .touchUpInside)
    }
    
    
    func setupUI() {
        view.addSubview(postTextView)
        view.addSubview(titleTextField)
        view.addSubview(themeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(checkMarkButton)
        view.addSubview(postButton)
        view.addSubview(countSymbol)
        
        
        
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
    
        
        postButton.tintColor = .white
        postButton.setImage(arrowTriangle, for: .normal)
        
        postButton.snp.makeConstraints { button in
            button.top.equalTo(postTextView.snp.bottom).offset(20)
            button.right.equalToSuperview().offset(-35)
            button.left.equalToSuperview().inset(170)
            button.height.equalTo(50)
        }
        
        
        //сделать так чтобы текст не залазил на этот label, и реализовать минимальное количество символов поста и максимальное. Так же реализовать чтобы значение 0 менялось а зависимости оттого сколько символов вписывается 
        countSymbol.text = "0/128"
        countSymbol.font = UIFont(name: "Helvetica-Bold", size: 13)
        countSymbol.textColor = .gray
        countSymbol.numberOfLines = 1
        countSymbol.snp.makeConstraints { symbol in
            symbol.trailing.equalTo(postTextView.snp.trailing).offset(-30)
            symbol.bottom.equalTo(postTextView.snp.bottom).inset(15)
            symbol.width.equalTo(35)
        }
        
    }
    
    @objc func checkMarkAction() {
        //добавить функционал для кнопки чека, по нажатию на нее было сохранение темы
    }
    
    @objc func postAction() {
        //добавить фуннкционал дл кнпоки post, сохранения данных естетственно которые добавили в textView и передачи его в tableView
    }
    
    
}
