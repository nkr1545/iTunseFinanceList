//
//  DetailScreenShotTableViewCell.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 12..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit

struct DetailScreenShotTableViewCellInfo {
    static let identifier = "DetailScreenShotTableViewCell"
    
    static let collectionMargin: CGFloat = 15.0
    static let itemSpacing: CGFloat      = 10.0
    static var itemWidth: CGFloat        = 186.0
    static let itemHeight: CGFloat       = 348.0
}

final class DetailScreenShotTableViewCell: UITableViewCell {

    var screenshotUrls = [String]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var currentPage: Int = 0
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewSetting()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func collectionViewSetting() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset       = UIEdgeInsets(top: 0, left: DetailScreenShotTableViewCellInfo.collectionMargin, bottom: 0, right: DetailScreenShotTableViewCellInfo.collectionMargin)
        layout.itemSize           = CGSize(width: DetailScreenShotTableViewCellInfo.itemWidth, height: DetailScreenShotTableViewCellInfo.itemHeight)
        layout.minimumLineSpacing = DetailScreenShotTableViewCellInfo.itemSpacing
        layout.scrollDirection    = .horizontal
        
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate     = UIScrollViewDecelerationRateFast
        collectionView.scrollsToTop         = false
    }
}

// MARK: - CollecionView Delegate
extension DetailScreenShotTableViewCell: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = DetailScreenShotTableViewCellInfo.itemWidth + DetailScreenShotTableViewCellInfo.itemSpacing
        var newPage = CGFloat(currentPage)

        if velocity.x == 0 {
            newPage = floor( (targetContentOffset.pointee.x + scrollView.frame.size.width / 2) / pageWidth)
        } else {
            newPage = CGFloat(velocity.x > 0 ? currentPage + 1 : currentPage - 1)

            if targetContentOffset.pointee.x - scrollView.contentOffset.x > DetailScreenShotTableViewCellInfo.itemWidth {
                newPage = newPage + 1

            } else if scrollView.contentOffset.x - targetContentOffset.pointee.x > DetailScreenShotTableViewCellInfo.itemWidth {
                newPage = newPage - 1
            }

            if newPage < 0 {
                newPage = 0
            }

            if (newPage > scrollView.contentSize.width / pageWidth) {
                newPage = ceil(scrollView.contentSize.width / pageWidth) - 1.0
            }
        }

        currentPage = Int(newPage)
        currentPage = min(screenshotUrls.count-1, currentPage)

        let point = CGPoint(x: CGFloat(currentPage) * pageWidth, y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
}

// MARK: - UICollectionView DataSource
extension DetailScreenShotTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshotUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenShotCollectionViewCellInfo.identifier, for: indexPath) as? ScreenShotCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.imageView.loadImage(urlString: screenshotUrls[indexPath.row])
        return cell
    }
}
