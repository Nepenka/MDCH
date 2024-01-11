//
//  WevViewrController.swift
//  MDCH
//
//  Created by 123 on 10.01.24.
//

import UIKit
import WebKit
import SnapKit

class WebViewrController: UIViewController {
    
    private let urlString: String
    private let webView = WKWebView()
    
    init(with urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        guard let url = URL(string: self.urlString) else {
            self.dismiss(animated: true)
            return
        }
        
        self.webView.load(URLRequest(url: url))
    }
    
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        self.view.addSubview(webView)
        
        webView.snp.makeConstraints { web in
            web.top.equalToSuperview()
            web.bottom.equalToSuperview()
            web.leading.equalToSuperview()
            web.trailing.equalToSuperview()
        }
    }

    @objc private func didTapDone() {
        self.dismiss(animated: true, completion: nil)
    }
   
}
