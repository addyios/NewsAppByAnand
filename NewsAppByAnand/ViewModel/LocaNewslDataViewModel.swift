//
//  LocaNewslDataVM.swift
//  NewsAppByAnand
//
//  Created by APPLE on 25/11/23.
//

import Foundation

class NoInterNetDataVM{
    
    var news_list: [Article] = []
    
    func offline_news_list(completion:@escaping () -> Void){
        if let jsonString = UserDefaults.standard.string(forKey: "JSONLocalStore"),
           let jsonData = jsonString.data(using: .utf8) {
            do {
                let decodedData = try JSONDecoder().decode(News.self, from: jsonData)
                self.news_list = decodedData.articles!
                completion()
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}
