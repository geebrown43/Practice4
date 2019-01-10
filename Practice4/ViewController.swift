//
//  ViewController.swift
//  Practice4
//
//  Created by Gavin Brown on 1/10/19.
//  Copyright © 2019 DevelopIT. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {  // after name of class must go super class or parent class then the protocol

    var webView: WKWebView!
    override func loadView() {
            webView = WKWebView()
            webView.navigationDelegate = self   // when any web navigation happens its telling the current view controller
            view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let url = URL(string: "https://www.gavindevelops.com")!
        webView.load(URLRequest(url: url))  // creates a new URL Request object from URL and passes to our webView to load
        webView.allowsBackForwardNavigationGestures  = true
    }

    @objc func openTapped() {
        let ac = UIAlertController(title: "Open", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem // this is only used on the iPad and tells where the action sheet should be anchored
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction){
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title // updates web view title property to page most recently loaded
    }

}

