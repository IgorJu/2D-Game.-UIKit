//
//  RecordListViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

class RecordListViewController: UITableViewController {
    
    let records: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientTable()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Record")
        var content = cell.defaultContentConfiguration()
        let records = records[indexPath.row]
        
        content.text = String(records.scores)
        content.textProperties.font = UIFont(name: "HelveticaNeue" , size: 18) ?? UIFont()
        content.textProperties.color = .white
        cell.contentConfiguration = content
        cell.backgroundConfiguration = .clear()
        
        
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
