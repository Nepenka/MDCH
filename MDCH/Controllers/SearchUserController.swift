//
//  SearchUserController.swift
//  MDCH
//
//  Created by 123 on 24.03.24.
//

import UIKit
import SnapKit
import FirebaseFirestore

class SearchUserController: UIViewController, UISearchResultsUpdating {
    
    let resultLabel: UILabel = {
        let result = UILabel()
        result.font = UIFont(name: "Helvetica-Bold", size: 10)
        result.numberOfLines = 0
        result.textAlignment = .center
        return result
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationTitle(title: "Search", withSearch: true)
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(resultLabel)
        view.addSubview(avatarImage)
        
        resultLabel.snp.makeConstraints { result in
            result.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            result.left.equalTo(view).offset(20)
            result.right.equalTo(view).offset(-20)
        }
        
        avatarImage.snp.makeConstraints { avatar in
            avatar.top.equalTo(resultLabel.snp.bottom).offset(20)
            avatar.centerX.equalTo(view)
            avatar.width.height.equalTo(80)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            resultLabel.text = "Please enter a unique identifier"
            return
        }
        searchUser(by: searchText)
    }
    
    private func searchUser(by uniqueIdentifier: String) {
        let db = Firestore.firestore()
        let userCollectionRef = db.collection("users")
        
        userCollectionRef.whereField("uniqueIdentifier", isEqualTo: uniqueIdentifier).getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            
            if let error = error {
                self.resultLabel.text = "Error: \(error.localizedDescription)"
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                self.resultLabel.text = "No user found with this identifier"
                return
            }
            
            let userData = documents[0].data()
            let username = userData["username"] as? String ?? "Unknown"
            let avatarURLString = userData["avatarURL"] as? String ?? ""
            
            self.resultLabel.text = "Username: \(username)"
            if let avatarURL = URL(string: avatarURLString) {
                self.loadAvatar(from: avatarURL)
            } else {
                self.avatarImage.image = nil
            }
        }
    }
    
    private func loadAvatar(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.avatarImage.image = UIImage(data: data)
            }
        }.resume()
    }
}
