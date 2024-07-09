//
//  NewsController.swift
//  MDCH
//
//  Created by 123 on 24.03.24.
//

import UIKit
import SnapKit
import FirebaseFirestore

class NewsController: UIViewController {
    
    let postButton: UIButton = CustomButton(title: "New Post", hasBackground: true, fontSize: .small)
    let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        return collectionView
    }()
    
    private lazy var newsScrollView: UIScrollView = {
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
    
    var posts: [Post] = [] 
    var previousPosts: [Post] = []
    
    private var listener: ListenerRegistration?
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 400)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        postButton.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
        newsScrollView.showsVerticalScrollIndicator = false
        setupNavigationTitle(title: "Newsfeed", withSearch: false)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        loadPosts()
    }
    
    deinit {
        listener?.remove()
    }
    
    private func setupUI() {
        view.addSubview(newsScrollView)
        view.addSubview(postButton)
        newsScrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        
        postButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.right.equalTo(view).offset(-20)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        collectionView.isScrollEnabled = false
        collectionView.snp.makeConstraints { collection in
            collection.top.equalToSuperview()
            collection.left.right.equalToSuperview()
            collection.bottom.equalTo(postButton.snp.top).offset(-30)
        }
    }
    
    @objc func postButtonAction() {
        let vc = PostViewController()
        navigationController?.present(vc, animated: true)
    }
    
    func loadPosts() {
        let postCollectionRef = Firestore.firestore().collection("posts")
        
        listener = postCollectionRef.addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let querySnapshot = querySnapshot else {
                print("No snapshot")
                return
            }
            
            print("Received \(querySnapshot.documents.count) documents")
            
            self.posts = querySnapshot.documents.compactMap { document -> Post? in
                let data = document.data()
                
                guard
                    let postId = data["postId"] as? String,
                    let userName = data["userName"] as? String,
                    let userId = data["userId"] as? String,
                    let avatarURL = data["avatarURL"] as? String,
                    let timestamp = data["timestamp"] as? Timestamp
                else {
                    return nil
                }
                return Post(postId: postId, userId: userId, userName: userName, timestamp: timestamp, avatarURL: avatarURL)
            }
            
            let diff = self.posts.difference(from: self.previousPosts)
            self.previousPosts = self.posts
            
            DispatchQueue.main.async {
                self.collectionView.performBatchUpdates({
                    for change in diff {
                        switch change {
                        case .insert(let offset, _, _):
                            self.collectionView.insertItems(at: [IndexPath(item: offset, section: 0)])
                        case .remove(let offset, _, _):
                            self.collectionView.deleteItems(at: [IndexPath(item: offset, section: 0)])
                        }
                    }
                }, completion: { _ in
                    self.collectionView.reloadData()
                })
            }
        }
    }
}

extension NewsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let post = posts[indexPath.row]
        cell.configure(with: post)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}

extension NewsController: NewsCollectionViewDelegate {
    func didTapDeleteButton(on cell: NewsCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        guard indexPath.row < posts.count else {
            print("Index out of range: indexPath.row \(indexPath.row), posts count \(posts.count)")
            return
        }
        
        let postID = posts[indexPath.row].postId
        let postCollectionRef = Firestore.firestore().collection("posts")
        let documentRef = postCollectionRef.document(postID)
        
        documentRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            guard document?.exists == true else {
                print("Document does not exist")
                return
            }
            
            documentRef.delete { error in
                if let error = error {
                    print("Error deleting document: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    if indexPath.row < self.posts.count {
                        self.posts.remove(at: indexPath.row)
                        self.previousPosts = self.posts
                        self.collectionView.deleteItems(at: [indexPath])
                    } else {
                        print("Index path out of range after deletion: \(indexPath)")
                    }
                }
                
                print("Document successfully deleted!")
            }
        }
    }
}
