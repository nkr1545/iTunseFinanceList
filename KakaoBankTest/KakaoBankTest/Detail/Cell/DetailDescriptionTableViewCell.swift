//
//  DetailDescriptionTableViewCell.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 12..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit

struct DetailDescriptionTableViewCellInfo {
    static let identifier = "DetailDescriptionTableViewCell"
}

final class DetailDescriptionTableViewCell: UITableViewCell {

    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
