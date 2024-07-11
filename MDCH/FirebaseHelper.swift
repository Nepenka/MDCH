//
//  FirebaseHelper.swift
//  MDCH
//
//  Created by 123 on 10.07.24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FirebaseHelper {
    
    // MARK: - Загрузка информации о пользователе
    public static func readUserNameFromFirebase(userId: String, userNameLabel: UILabel, avatarImageView: UIImageView) {
        let userCollectionRef = Firestore.firestore().collection("users")
        
        userCollectionRef.document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                if let username = document.data()?["username"] as? String {
                    userNameLabel.text = username
                }
                if let avatarURL = document.data()?["avatarURL"] as? String, !avatarURL.isEmpty {
                    loadAvatarImage(from: avatarURL, into: avatarImageView)
                } else {
                    avatarImageView.image = UIImage(named: "default_image")
                }
            } else {
                print("Документ не найден")
                avatarImageView.image = UIImage(named: "default_image")
            }
        }
    }
    
    // MARK: - Загрузка Аватара из Firebase
    public static func loadAvatarImage(from url: String, into imageView: UIImageView) {
        guard let url = URL(string: url) else {
            imageView.image = UIImage(named: "default_image")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "default_image")
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Ошибка при конвертации данных в изображение")
                DispatchQueue.main.async {
                    imageView.image = UIImage(named: "default_image")
                }
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
    
    // MARK: - Обновление лайков
    static func updateLikes(postId: String, userId: String, isLiked: Bool, completion: @escaping (Error?) -> Void) {
            let postRef = Firestore.firestore().collection("posts").document(postId)
            
            Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
                let postDocument: DocumentSnapshot
                do {
                    try postDocument = transaction.getDocument(postRef)
                } catch let error as NSError {
                    errorPointer?.pointee = error
                    return nil
                }
                
                guard let likedBy = postDocument.data()?["likedBy"] as? [String] else {
                    let error = NSError(domain: "AppErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve likedBy from snapshot \(postDocument)"])
                    errorPointer?.pointee = error
                    return nil
                }
                
                var updatedLikedBy = likedBy
                if isLiked {
                    updatedLikedBy.removeAll { $0 == userId }
                } else {
                    updatedLikedBy.append(userId)
                }
                
                transaction.updateData(["likedBy": updatedLikedBy], forDocument: postRef)
                return nil
            }) { (object, error) in
                completion(error)
            }
        }
}
