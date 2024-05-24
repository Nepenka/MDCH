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
    let tableView = UITableView()
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "cell")
        postButton.addTarget(self, action: #selector(postButtonAction), for: .touchUpInside)
        newsScrollView.showsVerticalScrollIndicator = false
    }
    
    private func setupUI() {
        view.addSubview(newsScrollView)
        newsScrollView.addSubview(contentView)
        contentView.addSubview(tableView)
        view.addSubview(postButton)
        
        postButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.right.equalTo(view).offset(-20)
                make.width.equalTo(150)
                make.height.equalTo(50)
            }
        
        
    }
    
    
    //MARK: - написать отдельный класс для функции чтобы нормально настроить textView и не говонокодить!!!
    
    @objc func postButtonAction() {
       
        let vc = PostViewController()
        navigationController?.present(vc, animated: true)
        
    }
}



extension NewsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        
        
        return cell 
    }
    
    
}
