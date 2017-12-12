//
//  AppStoreTableViewController.swift
//  KakaoBankTest
//
//  Created by nogyeongrae on 2017. 12. 10..
//  Copyright © 2017년 Snail. All rights reserved.
//

import UIKit

final class AppStoreTableViewController: UITableViewController {

    let dataManager = AppStoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "App Store 무료 금융앱 순위"
        
        dataManager.delegate = self
        dataManager.requestAppStoreFinaceList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Tableview DataSource, Delegate
extension AppStoreTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppStoreTableViewCellInfo.identifier) as? AppStoreTableViewCell else { return UITableViewCell() }
        
        cell.setGUI(entry: dataManager.entries[indexPath.row], rank: indexPath.row + 1)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let entry = dataManager.entries[indexPath.row]
        DispatchQueue.main.async {
            self.performSegue(with: .detail, sender: entry)
        }
    }
}

extension AppStoreTableViewController: AppStoreDataManagerDelegate {
    
    func completedNetwork() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Segue
extension AppStoreTableViewController: SegueHandlerType {
    
    // MARK: Enum
    enum SegueIdentifier: String {
        case detail         = "AppStoreDetailTableViewController"
    }

    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get Identifier
        guard let segueIdentifier = segueIdentifier(with: segue) else {
            print("Failed to get the segueIdentifier.")
            return
        }
        
        switch segueIdentifier {
        case .detail:
            guard let appStoreDetailTableViewController = segue.destination as? DetailTableViewController else { return }
            guard let entry = sender as? Entry else { return }
            appStoreDetailTableViewController.dataManager.entry = entry
        }
    }
}
