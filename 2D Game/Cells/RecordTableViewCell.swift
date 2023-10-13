//
//  RecordTableViewCell.swift
//  2D Game
//
//  Created by Igor on 12.10.2023.
//

import UIKit

final class RecordTableViewCell: UITableViewCell {
    
    static var identifier: String { "\(Self.self)" }
    
    private let recordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.textColor = .black
        
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }()
    
    private let avatarIV = UIImageView()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        avatarIV.translatesAutoresizingMaskIntoConstraints = false
        avatarIV.contentMode = .scaleAspectFit
        //avatarIV.image = UIImage(systemName: "person")
        //avatarIV.frame = CGRect(x: 20, y: 20, width: 50, height: 50)
        contentView.addSubview(recordLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(avatarIV)
        setConstraints()
    }
    
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            avatarIV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarIV.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatarIV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            //avatarIV.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarIV.widthAnchor.constraint(equalToConstant: 40),
            avatarIV.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.leadingAnchor.constraint(equalTo: avatarIV.trailingAnchor , constant: 50),
            userNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            recordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            recordLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        contentView.autoresizingMask = .flexibleHeight
    }
    
    
    func configure(with scores: Int, userName: String, userImage: UIImage) {
        recordLabel.text = String(scores)
        userNameLabel.text = userName
        avatarIV.image = userImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        recordLabel.text = nil
        userNameLabel.text = nil
        avatarIV.image = nil
    }
}
