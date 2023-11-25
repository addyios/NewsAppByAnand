//
//  ViewController.swift
//  NewsAppByAnand
//
//  Created by APPLE on 25/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newsTV: UITableView!
    let VM = FetchNewsVM()
    let offlineVM = NoInterNetDataVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchJsonData()
    }
    
    private func configureTableView() {
        newsTV.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        newsTV.rowHeight = UITableView.automaticDimension
        newsTV.estimatedRowHeight = 270.0
    }
    
    private func fetchJsonData(){
        if (isConnectedToNetwork()) {
            VM.get_news_list_get_api{ [self] in
                DispatchQueue.main.async { [self] in
                    newsTV.reloadData() } }
        }else{
            offlineVM.offline_news_list {
                DispatchQueue.main.async { [self] in
                    newsTV.reloadData() } }
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
}

