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
    var progressView: UIProgressView!
    var websites: [String] = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
            webView = WKWebView()
            webView.navigationDelegate = self   // when any web navigation happens its telling the current view controller
            view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default) // creates a new progress view instance
        progressView.sizeToFit() // sets layout size so that it fits content fully
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // creates space ...cannot be tapped
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        // First Item Loaded to screen
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))  // creates a new URL Request object from URL and passes to our webView to load
        webView.allowsBackForwardNavigationGestures  = true
        
        //Key value tells system when their is a change to web page progress
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil) // keyPath allows compiler to check that your code is correct(makes sure WKWeb has a estimated progress property)
        // Add Observer Parameters
        // 1. Who the observer is? --- self in this case
        // 2. What property are we observing -- estimated progress
        // 3. What value we want -- "the one we just set so in this case (.new)"
        // 4. Context value - nothing or nil
        
    }
    
    // All calls to addObserver() should be matched with a call to removeObserver()
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }

        // Function created to controll alert controller
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem // this is only used on the iPad and tells where the action sheet should be anchored
        present(ac, animated: true)
    }
    
        //Function activates the page opening
    
    func openPage(action: UIAlertAction){
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title // updates web view title property to page most recently loaded
    }

}

