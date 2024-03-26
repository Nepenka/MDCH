//
//  SearchUserController.swift
//  MDCH
//
//  Created by 123 on 24.03.24.
//

import UIKit
import SnapKit



class SearchUserController: UIViewController {
    let searchBar: UISearchBar = .init()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        setupUI()
       
    }
    
    private func setupUI() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { search in
            search.top.equalToSuperview().offset(60)
            search.left.right.equalToSuperview()
        }
        
        searchBar.placeholder = "Search..."
        searchBar.showsCancelButton = false
    }
    
}

extension SearchUserController: UISearchBarDelegate {
    
}
