//
//  RecordListViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

final class RecordListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let storageManager = StorageManager.shared
    
    private lazy var records: [User] = storageManager.loadRecords() ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        records = StorageManager.shared.loadRecords() ?? []
        tableView.superview?.addVerticalGradientLayer(
            topColor: ConstantColors.endColor,
            bottomColor: ConstantColors.startColor)
        
        tableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = .leastNonzeroMagnitude
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension RecordListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.identifier, for: indexPath) as? RecordTableViewCell else { return UITableViewCell() }
        
        //let record = records.sorted()[indexPath.row]
        
        let user = records[indexPath.row]
        
        cell.configure(
            with: user.record.scores,
            userName: user.name,
            userImage: storageManager.loadImage(name: user.imageName) ?? UIImage()
        )
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
