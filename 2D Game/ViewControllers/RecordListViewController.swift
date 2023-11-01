//
//  RecordListViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

final class RecordListViewController: UIViewController {
    //MARK: - Properties
    
    @IBOutlet var tableView: UITableView!
    
    private let storageManager = StorageManager.shared
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var userRecords: [User] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setActivityIndicator()
        fetchUserRecords()
        setTableView()
    }
    
    //MARK: - Flow
    private func setActivityIndicator() {
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
    }
    
   private func setTableView() {
        tableView.superview?.addVerticalGradientLayer(
            topColor: ConstantColors.endColor,
            bottomColor: ConstantColors.startColor
        )
        
        tableView.register(
            RecordTableViewCell.self,
            forCellReuseIdentifier: RecordTableViewCell.identifier
        )
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    private func fetchUserRecords() {
        DispatchQueue.global().async {
            let records = GameManager.shared.fetchUsers()
            
            DispatchQueue.main.async {
                self.userRecords = records
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()
            }
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension RecordListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RecordTableViewCell.identifier,
            for: indexPath
        ) as? RecordTableViewCell else { return UITableViewCell() }
        
        userRecords.sort { $0.record.scores > $1.record.scores }
        let user = userRecords[indexPath.row]
        
        cell.configure(user: user)
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.heightForRow
    }
}


