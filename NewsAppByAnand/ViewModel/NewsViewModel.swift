//
//  NewsViewModel.swift
//  NewsAppByAnand
//
//  Created by APPLE on 25/11/23.
//

import Foundation

class FetchNewsVM{
    
    var news_list: [Article] = []
    let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ecde381798b94c889109261631bf767f"
    
        func get_news_list_get_api(completion:@escaping () -> Void){
            if let url = URL(string: urlString) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("Error: \(error)")
                        return
                    }
                    guard let data = data else {
                        print("No data received")
                        return
                    }
                    do {
                        let jsonResponse = try JSONDecoder().decode(News.self, from: data)
                        self.news_list = jsonResponse.articles!
                        Helper.saveJSONData(data, forKey: "JSONLocalStore")
                        completion()
                    } catch let parsingError {
                        print("Error parsing data: \(parsingError)")
                    }
                }
                task.resume()
            }
        }
    }


