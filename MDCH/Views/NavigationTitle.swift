//
//  NavigationTitle.swift
//  MDCH
//
//  Created by 123 on 26.05.24.
//

import Foundation
import UIKit



extension UIViewController {
    
     func setupNavigationTitle(title: String, withSearch: Bool) {
        navigationItem.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        if withSearch == true {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self as? UISearchResultsUpdating
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.searchController = nil
        }
    }
}
