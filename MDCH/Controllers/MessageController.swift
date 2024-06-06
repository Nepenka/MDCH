//
//  MessageController.swift
//  MDCH
//
//  Created by 123 on 24.03.24.
//

import UIKit
import SnapKit



class MessageController: UIViewController {
   
    let tableView: UITableView = .init()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationTitle(title: "Message", withSearch: true)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { table in
            table.left.right.bottom.equalToSuperview()
            table.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}







extension MessageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MessageTableViewCell else {return UITableViewCell()}
        
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 2.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}

