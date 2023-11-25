//
//  NewsModel.swift
//  NewsAppByAnand
//
//  Created by APPLE on 25/11/23.
//

import Foundation

// MARK: - News
struct News: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String?
}

struct Helper {
    static func saveJSONData(_ jsonData: Data, forKey key: String) {
        let jsonString = String(data: jsonData, encoding: .utf8)
        UserDefaults.standard.set(jsonString, forKey: key)
        UserDefaults.standard.synchronize()
    }
    static func getJSONData(forKey key: String) -> Data? {
        if let jsonString = UserDefaults.standard.string(forKey: key),
           let jsonData = jsonString.data(using: .utf8) {
            return jsonData
        }
        return nil
    }
}
