//
//  DetailViewController.swift
//  Project7-Final
//
//  Created by Michelle Malixi on 3/15/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    private var webView: WKWebView!
    var viewModel: DetailViewModel!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let html  = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 130%; font-style: italic} </style>
        </head>
        <body>
        \(viewModel.getBody())
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
