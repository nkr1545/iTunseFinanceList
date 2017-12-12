//
//  Detail.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 11..
//  Copyright © 2017년 Snail. All rights reserved.
//


struct Detail {
    let name: String
    let artistName: String
    let imageURLString: String
    let screenshotUrls: [String]
    let description: String
}

extension Detail {
    init?(data: [String:Any]?) {
        guard let data = data else { return nil }

        name = data[JsonKey.trackName] as? String ?? ""
        artistName = data[JsonKey.artistName] as? String ?? ""
        imageURLString = data[JsonKey.artworkUrl100] as? String ?? ""
        screenshotUrls = data[JsonKey.screenshotUrls] as? [String] ?? [String]()
        description = data[JsonKey.description] as? String ?? ""
    }
}
