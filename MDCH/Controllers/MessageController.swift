//
//  MessageController.swift
//  MDCH
//
//  Created by 123 on 24.03.24.
//

import UIKit




class MessageController: UIViewController {
    let searchBar: UISearchBar = .init()
    let tableView: UITableView = .init()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupUI() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { search in
            search.top.equalToSuperview().offset(60)
            search.left.right.equalToSuperview()
        }
        searchBar.delegate = self
        searchBar.placeholder = "Search..."
        searchBar.showsCancelButton = false
        
        
        
        
    }
}




extension MessageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.layer.borderColor = UIColor.red.cgColor
        cell.layer.borderWidth = 2.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}

extension MessageController: UISearchBarDelegate {
    
}

