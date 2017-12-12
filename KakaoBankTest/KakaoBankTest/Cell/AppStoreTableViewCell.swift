//
//  AppStoreTableViewCell.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 10..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit

struct AppStoreTableViewCellInfo {
    static let identifier = "AppStoreTableViewCell"
}

final class AppStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        iconImageView.image = nil
        
        iconImageView.layer.cornerRadius = 10
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        let path = UIBezierPath(roundedRect: iconImageView.bounds, cornerRadius: 10)
        let mask      = CAShapeLayer()
        mask.path     = path.cgPath
        mask.fillRule = kCAFillRuleEvenOdd
        
        iconImageView.layer.mask = mask
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setGUI(entry: Entry, rank: Int) {
        
        nameLabel.text = entry.name
        rankLabel.text = "\(rank)"
        
        guard let lastEntryImageInfo = entry.image.last else { return }
        iconImageView.loadImage(urlString: lastEntryImageInfo.imageURLString)
    }
}
