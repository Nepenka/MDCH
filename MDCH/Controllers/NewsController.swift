//
//  NewsController.swift
//  MDCH
//
//  Created by 123 on 24.03.24.
//

import UIKit
import SnapKit



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
    }
    
    private func setupUI() {
            view.addSubview(newsScrollView)
            view.addSubview(postButton)
            newsScrollView.addSubview(contentView)
            contentView.addSubview(collectionView)
            //collectionViewSettings(collectionView)
            
            
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
}

extension NewsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCollectionViewCell else {return
           UICollectionViewCell()
        }
        
        cell.readUserNameFromFirebase()
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    
}
