//
//  Entry.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 10..
//  Copyright © 2017년 Snail. All rights reserved.
//

struct EntryImage {
    let imageURLString: String
    let height: Double
}

extension EntryImage {
    private enum CodingKeys: String, CodingKey {
        case label = "label"
        case attributes = "attributes"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageURLString = try values.decode(String.self, forKey: .label)
        
        let _attributes = try values.decode([String: String].self, forKey: .attributes)
        if let _height = _attributes[JsonKey.height] {
            height = Double(_height) ?? 0
        } else {
            height = 0
        }
    }
    
    init?(data: [String:Any]?) {
        guard let data = data else { return nil }
        
        guard let imageURLString = data[JsonKey.label] as? String,
            let attributes = data[JsonKey.attributes] as? [String:Any],
            let height = attributes[JsonKey.height] as? String else {
                return nil
        }
        
        self.imageURLString = imageURLString
        self.height = Double(height) ?? 0
    }
}

struct Entry {
    let name: String
    let appID: String
    let image: [EntryImage]
}

extension Entry {
    init?(data: [String:Any]?) {
        guard let data = data else { return nil }
        
        guard let imName = data[JsonKey.im_name] as? [String: Any],
            let _name = imName[JsonKey.label] as? String,
            let id = data[JsonKey.id] as? [String: Any],
            let idAttributes = id[JsonKey.attributes] as? [String: Any],
            let _appID = idAttributes[JsonKey.im_id] as? String,
            let images = data[JsonKey.im_image] as? [[String: Any]] else {
                return nil
        }

        name = _name
        appID = _appID
        image = images.flatMap({ EntryImage(data: $0) })
    }
}
