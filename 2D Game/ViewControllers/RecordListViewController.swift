//
//  RecordListViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

final class RecordListViewController: UITableViewController {
    
    private lazy var records: [Record] = GameManager.shared.fetchRecords()
    
    override func viewDidLoad() {
        records = StorageManager.shared.loadRecords() ?? []
        super.viewDidLoad()
        setupGradientTable()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Record")
        var content = cell.defaultContentConfiguration()
        
        let record = records.sorted()[indexPath.row]
        
        content.text = String(indexPath.row + 1) +  ". "  + String(record.scores) + " очков"
        content.textProperties.font = UIFont(name: "HelveticaNeue" , size: 18) ?? UIFont()
        content.textProperties.color = .white
        cell.contentConfiguration = content
        cell.backgroundConfiguration = .clear()
        
        return cell
    }
}
