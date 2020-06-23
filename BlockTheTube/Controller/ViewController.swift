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
    @IBOutlet weak var mode: UISwitch!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var counter = 0.0
    var timer = Timer()
    
    var watch = Stopwatch()
    
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
 
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if (host == "www.youtube.com" || host.contains("youtube")){
                if mode.isOn{
                    decisionHandler(.cancel)
                    self.performSegue(withIdentifier: "error", sender: self)
                    timer.invalidate()
                    watch.stop()
                    return
                }else{
                    fireTimer()
                }
            }
        }
       
        decisionHandler(.allow)
    }
    
    @IBAction func modeSelector(_ sender: UISwitch) {
        if !sender.isOn{
            modeLabel.text = "Mode: Timer"
        }else{
            timerLabel.isHidden = true
            timerLabel.text = ""
            searchBar.text = ""
            modeLabel.text = "Mode: Blocked"
            webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
            watch.stop()
            timer.invalidate()
        }
    
    }
    
    func fireTimer(){
        watch.start()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)

        timer.fire()
    }
    
    @objc func UpdateTimer(){
        let min = Int(watch.elapsedTime/60)
        let sec = Int(watch.elapsedTime.truncatingRemainder(dividingBy: 60))
        let tenOfSeconds = Int((watch.elapsedTime*10).truncatingRemainder(dividingBy: 10))
        timerLabel.text = String(format: "%02d:%02d:%02d", min,sec,tenOfSeconds)
    }
    
}

