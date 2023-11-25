//
//  ViewController.swift
//  NewsAppByAnand
//
//  Created by APPLE on 25/11/23.
//

import UIKit
import Network

class ViewController: UIViewController {
    
    @IBOutlet weak var newsTV: UITableView!
    
    private var monitor: NWPathMonitor?
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    let VM = FetchNewsVM()
    let offlineVM = NoInterNetDataVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { path in
            if path.status == .satisfied {
                // Internet connection is available
                print("Internet connection is available")
                self.configureTableView()
                self.fetchJsonData()
                
            } else {
                // No internet connection
                print("No internet connection")
                self.configureTableView()
                self.fetchJsonData()
            }
        }
        monitor?.start(queue: queue)
    }
    
    private func configureTableView() {
        DispatchQueue.main.async { [self] in
            newsTV.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
            newsTV.rowHeight = UITableView.automaticDimension
            newsTV.estimatedRowHeight = 270.0
        }
    }
    
    private func fetchJsonData(){
        if (isConnectedToNetwork()) {
            VM.get_news_list_get_api{ [self] in
                DispatchQueue.main.async { [self] in
                    newsTV.reloadData()
                    loadViewIfNeeded() } }
        }else{
            offlineVM.offline_news_list {
                DispatchQueue.main.async { [self] in
                    newsTV.reloadData()
                    loadViewIfNeeded() } }
        }
    }
}

//MARK :- Table view cell delegate and datasource
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isConnectedToNetwork()) {
            return VM.news_list.count
        }else{
            return offlineVM.news_list.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = newsTV.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell{
            
            if (isConnectedToNetwork()) {
                let article = VM.news_list[indexPath.row]
                cell.configure(with: article)
            }else{
                let article = offlineVM.news_list[indexPath.row]
                cell.configure(with: article)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndax = indexPath.row
        var news_url = ""
        if (isConnectedToNetwork()) {
            news_url = VM.news_list[selectedIndax].url ?? ""
        }else{
            news_url = offlineVM.news_list[selectedIndax].url ?? ""
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as? NewsDetailsViewController
        vc?.news_url = news_url
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

