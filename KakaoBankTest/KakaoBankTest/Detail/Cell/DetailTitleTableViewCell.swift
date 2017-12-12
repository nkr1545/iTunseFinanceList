//
//  DetailTitleTableViewCell.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 11..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit

struct DetailTitleTableViewCellInfo {
    static let identifier = "DetailTitleTableViewCell"
}

final class DetailTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        iconImageView.image = nil
        
        iconImageView.layer.cornerRadius = 20
        iconImageView.layer.borderWidth  = 0.5
        iconImageView.layer.borderColor  = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        let path = UIBezierPath(roundedRect: iconImageView.bounds, cornerRadius: 20)
        let mask      = CAShapeLayer()
        mask.path     = path.cgPath
        mask.fillRule = kCAFillRuleEvenOdd
        
        iconImageView.layer.mask = mask
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateGUI(data: Detail) {
        
        nameLabel.text = data.name
        companyNameLabel.text = data.artistName
        iconImageView.loadImage(urlString: data.imageURLString)
        
    }
}
