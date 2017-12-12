//
//  DetailDataManager.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 11..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit

struct DetailDataManagerURL {
    static let appStoreDetailInfo = { (appID: String) -> String in return "https://itunes.apple.com/lookup?id=\(appID)&country=kr" }
}

protocol DetailDataManagerDelegate: class {
    func completedNetwork()
}

final class DetailDataManager: NSObject {
    var entry: Entry?
    var detailInfo: Detail?
    weak var delegate: DetailDataManagerDelegate? = nil
    
    func requestAppStoreDetailInfo() {
        
        guard let entry = self.entry,
              let url = URL(string: DetailDataManagerURL.appStoreDetailInfo(entry.appID)) else {
                return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }

            self.handleAppStoreDetailInfo(data: data)

            }.resume()
    }
    
    private func handleAppStoreDetailInfo(data: Data?) {
        
        guard let data = data else { return }
        var responseData: [String: Any]?

        do {
            responseData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            // JSONDecoder().decode([Article].self, from: data)
        } catch let jsonError as NSError {
            print("JSONSerialization error: \(jsonError.localizedDescription)\n")
            return
        }
        
        guard let results = responseData?[JsonKey.results] as? [[String: Any]], results.isEmpty == false, let result = results.first else {
            return
        }
        
        detailInfo = Detail(data: result)
        
        DispatchQueue.main.async {
            self.delegate?.completedNetwork()
        }
    }
}
