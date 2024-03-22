//
//  WebViewController.swift
//  News
//
//  Created by Ibrahim Nasser Ibrahim on 22/03/2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK: - Properties
    var url: URLRequest
    
    // MARK: - IBOutlets
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Initialization
    init(url: URLRequest) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        progressView.progressTintColor = .nsecondarycolor
        webView.load(url)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == "estimatedProgress" {
            let newProgress = Float(self.webView.estimatedProgress)
            self.progressView.progress = newProgress
            
            if newProgress >= 1.0 {
                self.progressView.isHidden = true
            } else {
                self.progressView.isHidden = false
            }
        }
    }
}
