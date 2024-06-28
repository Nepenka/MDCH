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
    
    let postLabel: UILabel = {
       let post = UILabel()
        post.text = "Описание поста"
        post.textColor = UIColor.black
        post.numberOfLines = 1
        return post
    }()
    
    
    let heartButton: UIButton = {
        let heart = UIButton()
        heart.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return heart
    }()
    
    let messageButton: UIButton = {
       let message = UIButton()
        message.setImage(UIImage(systemName: "message"), for: .normal)
        
        return message
    }()
    
    let repostButton: UIButton = {
       let repost = UIButton()
        repost.setImage(UIImage(systemName: "arrow.turn.up.right"), for: .normal)
        
        return repost
    }()
    
    let IndCountLabel: UILabel = {
       let label = UILabel()
        label.text = "0"
        label.textColor = UIColor.black
        
        return label
    }()
    
    var IndCount: Int = 0
    var touchHeart: Bool = false
    
    let themeLabale: UILabel = {
       let theme = UILabel()
        theme.text = "Тема"
        theme.font = UIFont(name: "Helvetica-Bold", size: 12)
        theme.textColor = .black
        
        return theme
    }()
    
    let timePostLabel: UILabel = {
       let timePost = UILabel()
        timePost.textColor = .black
        timePost.font = UIFont(name: "Helvetica-Bold", size: 10)
       
        
        return timePost
    }()
    
    let deleteButton: UIButton = {
       let delete = UIButton()
        delete.setImage(UIImage(systemName: "trash"), for: .normal)
        
        return delete
    }()
    
    weak var delegate: NewsCollectionViewDelegate?
   
    private func buttonRegister() {
        repostButton.addTarget(self, action: #selector(repostAction), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(messageAction), for: .touchUpInside)
        heartButton.addTarget(self, action: #selector(heartAction), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
    }
    
    
    func setupViews() {
        contentView.addSubview(userName)
        contentView.addSubview(avatar)
        contentView.addSubview(heartButton)
        contentView.addSubview(postLabel)
        contentView.addSubview(messageButton)
        contentView.addSubview(repostButton)
        contentView.addSubview(IndCountLabel)
        contentView.addSubview(themeLabale)
        contentView.addSubview(timePostLabel)
        contentView.addSubview(deleteButton)
        
        userName.snp.makeConstraints { user in
            user.left.equalTo(avatar.snp.right).offset(10)
            user.centerY.equalTo(avatar.snp.centerY)
        }
        
        avatar.snp.makeConstraints { image in
            image.left.equalToSuperview().offset(30)
            image.top.equalToSuperview().offset(45)
            image.height.width.equalTo(50)
        }
        
        postLabel.snp.makeConstraints { post in
            post.top.equalTo(userName.snp.bottom).offset(30)
            post.left.equalToSuperview().offset(90)
        }
        
        heartButton.snp.makeConstraints { heart in
            heart.top.equalTo(postLabel.snp.bottom).offset(45)
            heart.left.equalToSuperview().offset(50)
        }
        
        messageButton.snp.makeConstraints { message in
            message.left.equalTo(heartButton.snp.right).offset(120)
            message.top.equalTo(postLabel.snp.bottom).offset(45)
        }
        
        repostButton.snp.makeConstraints { repost in
            repost.left.equalTo(messageButton.snp.right).offset(120)
            repost.top.equalTo(postLabel.snp.bottom).offset(45)
        }
        
        IndCountLabel.snp.makeConstraints { likes in
            likes.top.equalTo(postLabel.snp.bottom).offset(45)
            likes.left.equalTo(heartButton.snp.right).offset(10)
        }
        
        themeLabale.snp.makeConstraints { theme in
            theme.left.equalTo(userName.snp.right).offset(20)
            theme.centerY.equalTo(userName.snp.centerY)
        }
        
        timePostLabel.snp.makeConstraints { time in
            time.left.equalTo(themeLabale.snp.right).offset(15)
            time.centerY.equalTo(themeLabale.snp.centerY)
        }
        
        deleteButton.snp.makeConstraints { delete in
            delete.left.equalTo(timePostLabel.snp.right).offset(10)
            delete.centerY.equalTo(timePostLabel.snp.centerY)
            delete.height.equalTo(30)
        }
        
        
    }
    
    func readUserNameFromFirebase() {
        let userCollectionRef = Firestore.firestore().collection("users")
        
        if let currentUserUID = Auth.auth().currentUser?.uid {
            userCollectionRef.document(currentUserUID).getDocument { [weak self] (document, error) in
                guard let self = self else { return }
                
                if let document = document, document.exists {
                    if let username = document.data()?["username"] as? String {
                        self.userName.text = username
                    }
                    if let avatarURL = document.data()?["avatarURL"] as? String, !avatarURL.isEmpty {
                        self.loadAvatarImage(from: avatarURL)
                    } else {
                        self.avatar.image = UIImage(named: "default_image")
                    }
                } else {
                    print("Документ не найден")
                    self.avatar.image = UIImage(named: "default_image")
                }
            }
        }
    }
    
    private func loadAvatarImage(from url: String) {
        guard let url = URL(string: url) else {
            self.avatar.image = UIImage(named: "default_image")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.avatar.image = UIImage(named: "default_image")
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Ошибка при конвертации данных в изображение")
                DispatchQueue.main.async {
                    self?.avatar.image = UIImage(named: "default_image")
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.avatar.image = image
            }
        }.resume()
    }
    
    private func readPostDataFirebase(postID: String) {
        let postCollectionRef = Firestore.firestore().collection("posts")
        
        postCollectionRef.document(postID).getDocument { [weak self] (document, error) in
            guard let self = self else {return}
            
            if let document = document, document.exists {
                if let theme = document.data()?["theme"] as? String {
                    self.themeLabale.text = theme
                }
                
                if let desription = document.data()?["description"] as? String {
                    self.postLabel.text = desription
                }
            }
            if let timestamp = document?.data()?["timestamp"] as? Timestamp {
                let date = timestamp.dateValue()
                let formatt = DateFormatter()
                formatt.dateFormat = "dd.MM.yyyy HH:mm"
                self.timePostLabel.text = formatt.string(from: date)
            }else{
                print("Документ не найден")
            }
        }
    }
    
    @objc func repostAction() {
        //С этим придется поработать когда будут реализованы сообщения
    }
    
    @objc func messageAction() {
        //Подумать над тем как реализовать коменнтарии
    }
    
    @objc func heartAction() {
        touchHeart.toggle()
        IndCount += touchHeart ? 1 : -1
        IndCountLabel.text = "\(IndCount)"
    }
    
    @objc func deleteAction() {
        delegate?.didTapDeleteButton(on: self)
    }
    
    func configure(with postID: String) {
        readPostDataFirebase(postID: postID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        readUserNameFromFirebase()
        buttonRegister()
    }
}


protocol NewsCollectionViewDelegate: AnyObject {
    func didTapDeleteButton(on cell: NewsCollectionViewCell)
    
}
