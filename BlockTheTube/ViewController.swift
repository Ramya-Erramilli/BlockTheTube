//
//  ViewController.swift
//  BlockTheTube
//
//  Created by Ramya Seshagiri on 23/06/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        
        webView.navigationDelegate = self
        

    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if var text =  searchBar.text{
            if !text.contains("https://"){
                text = "https://\(text)"
            }
            if let url = URL(string: text){
                let req = URLRequest(url: url)
                self.webView.load(req)
            }
        }
    }
    @IBOutlet weak var mode: UISwitch!
    @IBOutlet weak var modeLabel: UILabel!
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if (host == "www.youtube.com" || host.contains("youtube")) && mode.isOn {
                decisionHandler(.cancel)
                self.performSegue(withIdentifier: "error", sender: self)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    @IBAction func modeSelector(_ sender: UISwitch) {
        if !sender.isOn{
            modeLabel.text = "Mode: Timer"
            
        }else{
            modeLabel.text = "Mode: Blocked"
        }
    
    }
    
}


