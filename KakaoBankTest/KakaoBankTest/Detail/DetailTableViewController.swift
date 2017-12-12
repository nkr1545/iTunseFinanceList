//
//  AppStoreDetailTableViewController.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 11..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit

enum DetailTableViewCellType: Int {
    case title           = 0
    case screenShot
    case description
    
    static var count: Int { return DetailTableViewCellType.description.hashValue + 1 }
}

final class DetailTableViewController: UITableViewController {

    let dataManager = DetailDataManager()
    
    @IBOutlet weak var detailTitleTableViewCell: DetailTitleTableViewCell!
    @IBOutlet weak var detailScreenShotTableViewCell: DetailScreenShotTableViewCell!
    @IBOutlet weak var detailDesctiptionTableViewCell: DetailDescriptionTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight          = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        
        dataManager.delegate = self
        dataManager.requestAppStoreDetailInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailTableViewController: DetailDataManagerDelegate {
    
    func completedNetwork() {
        
        guard let detailInfo = dataManager.detailInfo else {
            return
        }
        
        detailTitleTableViewCell.updateGUI(data: detailInfo)
        detailScreenShotTableViewCell.screenshotUrls = detailInfo.screenshotUrls
        detailDesctiptionTableViewCell.descriptionLabel.text = detailInfo.description
    }
}

// MARK: - Tableview DataSource, Delegate
extension DetailTableViewController {
    
    open override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailTableViewCellType.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cellType = DetailTableViewCellType(rawValue: indexPath.row) else { return }
        
        switch cellType {
        case .description:

            detailDesctiptionTableViewCell.descriptionLabel.numberOfLines = 0
            
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            detailDesctiptionTableViewCell.updateConstraintsIfNeeded()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            
        default: break
        }
    }
}
