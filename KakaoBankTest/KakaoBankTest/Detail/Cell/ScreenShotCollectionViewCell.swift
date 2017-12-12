//
//  ScreenShotCollectionViewCell.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 12..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit

struct ScreenShotCollectionViewCellInfo {
    static let identifier = "ScreenShotCollectionViewCell"
}

final class ScreenShotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        imageView.image = nil
        
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth  = 1
        imageView.layer.borderColor  = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        let path = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 5)
        let mask      = CAShapeLayer()
        mask.path     = path.cgPath
        mask.fillRule = kCAFillRuleEvenOdd
        
        imageView.layer.mask = mask
    }
}
