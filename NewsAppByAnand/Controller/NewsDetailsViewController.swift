//
//  NewsDetailsViewController.swift
//  NewsAppByAnand
//
//  Created by APPLE on 25/11/23.
//

import UIKit
import WebKit

class NewsDetailsViewController: UIViewController {
    
    @IBOutlet weak var new_web_view: WKWebView!
    var news_url = ""
    
    @IBOutlet weak var errorLbl: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        internetCheck()
        LoadNewsURL()
    }
    private func internetCheck(){
        if (isConnectedToNetwork()) {
            errorLbl.constant = 0
        }else{
            errorLbl.constant = 20
        }
    }
    
    private func LoadNewsURL(){
        if let url = URL(string: news_url) {
            let request = URLRequest(url: url)
            new_web_view.load(request)
        }
    }
    
    @IBAction func clickToBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
