//
//  WebViewController.swift
//  NFTAPIDemo
//
//  Created by Manabu Shimada on 03/08/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private let webView = WKWebView()
    
    var url: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = view.frame
        view.addSubview(webView)
        
        load(url: self.url)

    }
    
    
    func load(url: String)  {
        let url = URL(string:url)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
}
