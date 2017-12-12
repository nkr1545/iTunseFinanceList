//
//  UIImageViewExtension.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 11..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit

let timeoutInterval: TimeInterval = 5 * 60;

extension UIImageView {

    func loadImage(urlString: String){
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: timeoutInterval)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration,
                                 delegate: nil,
                                 delegateQueue: OperationQueue.main)
        
        session.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                guard let data = data else { return }
                self.image = UIImage(data: data)
            } else {
                guard let error = error else { return }
                print("loadImage Error : \(error.localizedDescription)")
            }
            
        }.resume()
    }
}
