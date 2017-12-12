//
//  AppStoreListDataManager.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 10..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit

struct AppStoreDataManagerURL {
    static let appStoreFinaceList = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=6015/json"
}

protocol AppStoreDataManagerDelegate: class {
    func completedNetwork()
}

final class AppStoreDataManager: NSObject {
    
    var entries = [Entry]()
    weak var delegate: AppStoreDataManagerDelegate? = nil
    
    func requestAppStoreFinaceList() {
        
        guard let url = URL(string: AppStoreDataManagerURL.appStoreFinaceList) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            self.handleAppStoreFinaceList(data: data)
            
        }.resume()
    }
    
    private func handleAppStoreFinaceList(data: Data?) {
        
        guard let data = data else { return }
        var responseData: [String: Any]?
        
        do {
            responseData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            // JSONDecoder().decode([Article].self, from: data)
        } catch let jsonError as NSError {
            print("JSONSerialization error: \(jsonError.localizedDescription)\n")
            return
        }
        
        guard let feed = responseData?[JsonKey.feed] as? [String: Any], let entries = feed[JsonKey.entry] as? [[String: Any]] else {
            return
        }
        
        self.entries = entries.flatMap({ Entry(data: $0)})
        
        DispatchQueue.main.async {
            self.delegate?.completedNetwork()
        }
    }
}
